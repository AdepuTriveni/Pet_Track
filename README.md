# 🐾 PetTrack

PetTrack is a cross-platform application to help people report **lost** and **found** pets.  
When users upload pet details and images, the system stores them and allows comparison between lost and found records to help identify potential matches.

The solution streamlines the process of reuniting pets with their owners.

---

## Features

- Login & signup using Firebase Authentication
- Add **Lost Pet** records
- Add **Found Pet** records
- Image upload handled through **Cloudinary**
- Location capture support
- All pet data stored in **MongoDB Atlas**
- **Match scoring** is performed using CLIP ViT-B/32 embeddings (backend API)

---

## System Flow

Flutter App → Upload Pet + Image → Cloudinary (Image URL)
↓
Send Data to FastAPI Backend → MongoDB Atlas
↓
Match Engine compares Lost vs Found → Generates match score

yaml
Copy code

---

## Tech Stack

| Component | Technology |
|---------|------------|
| Frontend | Flutter |
| Authentication | Firebase Auth |
| Backend API | FastAPI (Python) |
| Database | MongoDB Atlas |
| Image Storage | Cloudinary |
| Similarity Model | CLIP ViT-B/32 (SentenceTransformers) |
| Geolocation | geopy |

---

## Folder Structure

PetTrack/
├── frontend/ # Flutter application
├── backend/ # FastAPI backend
│ ├── main.py
│ ├── matching_engine.py
│ ├── database.py
│ ├── models/
│ ├── utils.py
│ └── config.py
└── README.md

yaml
Copy code

---

## Configuration

Backend `.env` file:

PORT=5000
MONGO_URI = "mongodb+srv://Triveni:adepu123@cluster0.2glwj.mongodb.net/pettrack?retryWrites=true&w=majority"
CLOUDINARY_CLOUD_NAME=dslut5epx
CLOUDINARY_API_KEY=521144718367952
CLOUDINARY_API_SECRET=ebI-SCePYWWA9Q9PfxYhGllH7U8
SKIP_AUTH=true
MATCHING_API_URL=http://localhost:8000/match_score
MATCH_THRESHOLD=0.7
EMAIL_USER=pettrack778@gmail.com
EMAIL_PASS=fxnx urbg ufra xcdl

makefile
Copy code

`backend/config.py`:

```python
MONGO_URI = "mongodb+srv://Triveni:adepu123@cluster0.2glwj.mongodb.net/pettrack?retryWrites=true&w=majority"
DB_NAME = "pettrack"
Backend Setup
bash
Copy code
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
API docs:
http://localhost:8000/docs

Frontend Setup (Flutter)
bash
Copy code
cd frontend
flutter pub get
flutter run
How Matching Works (Simple Explanation)
When a Found pet is added, the backend retrieves all Lost pets.

The CLIP model converts both images to embedding vectors.

Cosine similarity is computed.

If the score exceeds the threshold (0.7), it is treated as a potential match.

Matches are shown in the Matches screen.

Future Enhancements
Automatic notification to the pet owner when a match is found

Push notifications (Firebase Cloud Messaging)

Improved scoring by including more pet attributes