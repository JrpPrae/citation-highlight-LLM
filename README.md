# Citation Highlight LLM API

API บริการสำหรับทำ Citation Highlight โดยใช้ LLM (Large Language Model) เพื่อค้นหาและไฮไลท์ข้อความจาก AI Answer ที่ตรงกับข้อมูลใน Chunks ที่กำหนด

## 📋 สารบัญ

- [ภาพรวม](#ภาพรวม)
- [Tech Stack](#tech-stack)
- [โครงสร้างโปรเจกต์](#โครงสร้างโปรเจกต์)
- [Workflow](#workflow)
- [การติดตั้งและใช้งาน](#การติดตั้งและใช้งาน)
- [API Endpoint](#api-endpoint)
- [ตัวอย่างการใช้งาน](#ตัวอย่างการใช้งาน)
- [Environment Variables](#environment-variables)
- [การพัฒนาและ Debug](#การพัฒนาและ-debug)

---

## 📖 ภาพรวม

Citation Highlight LLM API เป็นบริการที่ช่วยตรวจสอบและไฮไลท์ข้อความจาก AI Answer ที่ตรงกับข้อมูลต้นทาง (Chunks) โดยใช้ LLM Model ในการวิเคราะห์และทำ Highlight ด้วย HTML tags (`<h>` สำหรับหัวข้อ และ `<mark>` สำหรับข้อความที่ไฮไลท์)

### ฟีเจอร์หลัก
- ✅ ตรวจสอบความถูกต้องของ AI Answer กับข้อมูลต้นทาง
- ✅ ไฮไลท์ข้อความที่ตรงกันด้วย HTML tags
- ✅ รองรับ multiple chunks
- ✅ แสดงผลเฉพาะ chunk ที่พบข้อมูล
- ✅ Handle กรณีไม่พบข้อมูล

---

## 🛠 Tech Stack

| Technology | Version | Description |
|------------|---------|-------------|
| **Python** | 3.12+ | ภาษาหลักในการพัฒนา |
| **FastAPI** | Latest | Web Framework สำหรับสร้าง API |
| **Uvicorn** | Latest | ASGI Server สำหรับรัน FastAPI |
| **Pydantic** | Latest | Data validation และ schema management |
| **Requests** | Latest | HTTP client สำหรับเรียก LLM API |
| **python-dotenv** | Latest | จัดการ environment variables |
| **Docker** | Latest | Containerization |
| **Docker Compose** | Latest | Multi-container orchestration |

---

## 📁 โครงสร้างโปรเจกต์

```
citation-highlight-LLM/
├── .git/                    # Git repository
├── .gitignore               # Git ignore rules
├── app/
│   ├── .env                 # Environment variables (ไม่รวมใน git)
│   └── citation.py          # Main application code
├── docker-compose.yml       # Docker Compose configuration
├── Dockerfile               # Docker image configuration
└── requirements.txt         # Python dependencies
```

---

## 🔄 Workflow

```
Client Request → FastAPI Endpoint → Validate Request → Prepare Prompt → 
Call LLM API → Process Response → Return Highlighted Chunks → Client
```

### ขั้นตอนการทำงาน

1. **รับ Request**: Client ส่ง POST request พร้อม `answer` และ `chunks`
2. **Validate**: Pydantic schema ตรวจสอบความถูกต้องของข้อมูล
3. **สร้าง Prompt**: ระบบสร้าง prompt สำหรับ LLM โดยรวม AI answer และ chunks
4. **เรียก LLM API**: ส่ง request ไปยัง LLM Model API
5. **Process Result**: LLM วิเคราะห์และ return chunks ที่มีการ highlight
6. **Response**: ส่งผลลัพธ์กลับไปยัง client

---

## 🚀 การติดตั้งและใช้งาน

### ข้อกำหนดเบื้องต้น

- Python 3.12 หรือสูงกว่า
- Docker และ Docker Compose (สำหรับ Docker deployment)
- API Key สำหรับ LLM Model

### การติดตั้งแบบ Docker (แนะนำ)

1. **สร้างไฟล์ `.env` ในโฟลเดอร์ `app/`**:
   ```bash
   cd app
   echo API_KEY_MODEL=your_api_key_here > .env
   echo APP_PORT=8000 >> .env
   echo DEBUG=False >> .env
   ```

2. **Build และ Run ด้วย Docker Compose**:
   ```bash
   docker-compose up --build
   ```

3. **เข้าถึง API**:
   ```
   http://localhost:8000
   ```

4. **API Documentation**:
   ```
   http://localhost:8000/docs
   ```

### การติดตั้งแบบ Manual

1. **Clone หรือ Download โปรเจกต์**:
   ```bash
   cd citation-highlight-LLM
   ```

2. **สร้าง Virtual Environment** (แนะนำ):
   ```bash
   python -m venv venv
   venv\Scripts\activate  # Windows
   # source venv/bin/activate  # Linux/Mac
   ```

3. **ติดตั้ง Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

4. **สร้างไฟล์ `.env` ในโฟลเดอร์ `app/`**:
   ```
   API_KEY_MODEL=your_api_key_here
   APP_PORT=8000
   DEBUG=False
   ```

5. **รัน Application**:
   ```bash
   cd app
   uvicorn citation:app --host 0.0.0.0 --port 8000 --reload
   ```

6. **เข้าถึง API**:
   ```
   http://localhost:8000
   ```
