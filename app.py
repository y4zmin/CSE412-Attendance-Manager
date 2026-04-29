import os
from flask import Flask, render_template, request, redirect
import psycopg2
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

def get_db_connection():
        return psycopg2.connect(os.getenv("DB_URL"))


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/signup", methods=["POST"])
def signup():
    username = request.form["username"]
    firstname = request.form["firstname"]
    lastname = request.form["lastname"]
    password = request.form["password"]
    usertype = request.form["usertype"]

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO users (username, firstname, lastname, password, usertype)
        VALUES (%s, %s, %s, %s, %s)
    """, (username, firstname, lastname, password, usertype)) 

    userid = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()

    if usertype == "student":
         return redirect(f"/student/{userid}")
    elif usertype == "teacher":
        return redirect(f"/teacher/{userid}")
    else:
        return redirect("/")

@app.route("/login", methods=["POST"])
def login():
    username = request.form["username"]
    password = request.form["password"]

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT userid, firstname, usertype
        FROM users
        WHERE username = %s AND password = %s
    """, (username, password))

    result = cur.fetchone()

    cur.close()
    conn.close()

    if result:
        userid = result[0]
        firstname = result[1]
        usertype = result[2]

        if usertype == "student":
            return redirect(f"/student/{userid}")
        else:
            return redirect(f"/teacher/{userid}")

    return redirect("/")

@app.route("/student/<int:userid>")
def student(userid):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT firstname
        FROM users
        WHERE userid = %s
    """, (userid,))

    result = cur.fetchone()

    cur.close()
    conn.close()

    if result:
        return render_template("student.html", name=result[0])

    return redirect("/")

@app.route("/teacher/<int:userid>")
def teacher(userid):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT firstname
        FROM users
        WHERE userid = %s
    """, (userid,))

    result = cur.fetchone()

    cur.close()
    conn.close()

    if result:
        return render_template("teacher.html", name=result[0])
    return redirect("/")


if __name__ == "__main__":
    app.run(debug=True)