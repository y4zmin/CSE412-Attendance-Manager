from flask import Flask, render_template
import psycopg2


app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")




if __name__ == "__main__":
    app.run(debug=True)

conn = psycopg2.connect(
    host="localhost",
    database="attendancedb",
    user="postgres",
    password="1234"
)

cur = conn.cursor()