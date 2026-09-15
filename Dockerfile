# ใช้ Python base image
FROM python:3.12-slim

# ตั้ง working directory
WORKDIR /app

# คัดลอกไฟล์ requirements.txt
COPY requirements.txt .

# ติดตั้ง dependencies
RUN pip install --no-cache-dir -r requirements.txt

# คัดลอกโค้ดทั้งหมด
COPY . .

# Expose port ที่ uvicorn จะรัน
EXPOSE 8000

# คำสั่งเริ่มต้นเมื่อ container run
CMD ["uvicorn", "app.citation:app", "--host", "0.0.0.0", "--port", "8000"]