import os
from flask import Flask, render_template
import psycopg2
from dotenv import load_dotenv


load_dotenv()

app = Flask(__name__)

db_url = "postgresql://postgres:NMxZ2Ov8kz0M78hg@db.mrwaacfrwwyfsjyzwgld.supabase.co:5432/postgres"

def get_db_connection():
        return psycopg2.connect(db_url)


@app.route("/")
def home():
    return render_template("index.html")


if __name__ == "__main__":
    app.run(debug=True)