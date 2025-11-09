# 🐾 PetTrack

PetTrack is a cross-platform application to help people report **lost** and **found** pets.  
When users upload pet details and images, the system stores them and compares lost and found records to help identify potential matches.  
This helps streamline the process of reuniting pets with their owners.

---

## Features

- Login & signup using Firebase Authentication
- Add **Lost Pet** records
- Add **Found Pet** records
- Image upload handled through **Cloudinary**
- Location capture support
- All pet data stored in **MongoDB Atlas**
- **Match scoring** is performed using CLIP ViT-B/32 embeddings (FastAPI backend)

---

## System Flow

Flutter App → Upload Pet + Image → Cloudinary (Image URL)
↓
Send Data to FastAPI Backend → MongoDB Atlas
↓
Matching Engine compares Lost vs Found → Generates match score

yaml
Copy code

![System Flow](./SystemFlow.png)

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
│ ├── main.py # API entry
│ ├── matching_engine.py # CLIP similarity logic
│ ├── database.py # MongoDB connection
│ ├── models/ # Pydantic models
│ ├── utils.py # Helper functions
│ └── config.py # Configuration
└── README.md

yaml
Copy code

---

## Configuration

Create `.env` in backend:

PORT=5000

MongoDB Connection
MONGO_URI="your_mongodb_atlas_connection_string"

Cloudinary Credentials
CLOUDINARY_CLOUD_NAME="your_cloudinary_cloud_name"
CLOUDINARY_API_KEY="your_cloudinary_api_key"
CLOUDINARY_API_SECRET="your_cloudinary_api_secret"

Matching Engine
MATCHING_API_URL=http://localhost:8000/match_score
MATCH_THRESHOLD=0.7

Email Configuration (if used)
EMAIL_USER="your_email_here"
EMAIL_PASS="your_app_password_here"

makefile
Copy code

`backend/config.py`:

```python
MONGO_URI = "your_mongodb_atlas_connection_string"
DB_NAME = "pettrack"
Backend Setup
bash
Copy code
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
API docs: http://localhost:8000/docs

Frontend Setup (Flutter)
bash
Copy code
cd frontend
flutter pub get
flutter run
How Matching Works (Simple Explanation)
When a Found pet is added, the backend retrieves all Lost pets.

CLIP ViT-B/32 converts both images into embedding vectors.

Cosine similarity is calculated.

If similarity ≥ threshold (0.7), it is considered a match.

Match appears in the Matches section.

Future Enhancements
Show uploader/owner details in pet card.

Auto-archive lost pet records after 1–2 months to avoid database clutter.

Implement email notifications when a match is detected.

Add chat interface for communication between finder and pet owner.

Provide My Pets screen for users to edit/manage their uploaded records.

## Screenshots

### Login Screen
🔗 [View Screenshot](./login.png)

### Add Lost Pet Screen
🔗 [View Screenshot](./los_pet.jpg)

### Add Found Pet Screen
🔗 [View Screenshot](./found_pet.jpg)

### Matches Screen
🔗 [View Screenshot](./matches.jpg)
