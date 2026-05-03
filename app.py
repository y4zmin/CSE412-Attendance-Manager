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
        VALUES (%s, %s, %s, %s, %s) RETURNING userid
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

    user = cur.fetchone()

    if not user:
        cur.close()
        conn.close()
        return redirect("/")

    cur.execute("""
        SELECT c.classid, c.classname, c.classdesc, c.category
        FROM enrollment e
        JOIN classes c ON e.classid = c.classid
        WHERE e.userid = %s
        ORDER BY c.classname
    """, (userid,))

    enrolled_classes = cur.fetchall()

    cur.execute("""
        SELECT classid, classname, classdesc, category
        FROM classes
        WHERE classid NOT IN (
            SELECT classid
            FROM enrollment
            WHERE userid = %s
        )
        ORDER BY classname
    """, (userid,))

    available_classes = cur.fetchall()

    cur.execute("""
        SELECT ar.classid, c.classname, ar.meetdate, ar.attendance
        FROM attendancerecord ar
        JOIN classes c ON ar.classid = c.classid
        WHERE ar.userid = %s
        ORDER BY ar.meetdate DESC
    """, (userid,))

    attendance_records = cur.fetchall()

    cur.close()
    conn.close()

    return render_template(
        "student.html",
        userid=userid,
        name=user[0],
        enrolled_classes=enrolled_classes,
        available_classes=available_classes,
        attendance_records=attendance_records
    )


@app.route("/student/<int:userid>/join", methods=["POST"])
def join_class(userid):
    classid = request.form["classid"]

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO enrollment (userid, classid)
        VALUES (%s, %s)
        ON CONFLICT (userid, classid) DO NOTHING
    """, (userid, classid))

    conn.commit()
    cur.close()
    conn.close()

    return redirect(f"/student/{userid}")


@app.route("/student/<int:userid>/leave/<int:classid>", methods=["POST"])
def leave_class(userid, classid):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        DELETE FROM enrollment
        WHERE userid = %s AND classid = %s
    """, (userid, classid))

    conn.commit()
    cur.close()
    conn.close()

    return redirect(f"/student/{userid}")


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