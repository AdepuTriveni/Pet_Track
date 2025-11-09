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

![alt text](image-1.png)

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

# MongoDB Connection
MONGO_URI="your_mongodb_atlas_connection_string"

# Cloudinary Credentials
CLOUDINARY_CLOUD_NAME="your_cloudinary_cloud_name"
CLOUDINARY_API_KEY="your_cloudinary_api_key"
CLOUDINARY_API_SECRET="your_cloudinary_api_secret"

# Matching Engine
MATCHING_API_URL=http://localhost:8000/match_score
MATCH_THRESHOLD=0.7

# Email Configuration (if used)
EMAIL_USER="your_email_here"
EMAIL_PASS="your_app_password_here"



`backend/config.py`:

```python
MONGO_URI = "your-mongodb-atlas-url"
DB_NAME = "pettrack"
## Backend Setup

```bash
# Start Backend API
cd backend
pip install -r requirements.txt
uvicorn main:app --reload

API docs:
http://localhost:8000/docs

##Frontend Setup (Flutter)
flutter pub get
flutter run
How Matching Works (Simple Explanation)
When a Found pet is added, the backend retrieves all Lost pets.

The CLIP model converts both images to embedding vectors.

Cosine similarity is computed.

If the score exceeds the threshold (0.7), it is treated as a potential match.

Matches are shown in the Matches screen.

## Future Enhancements

- Show the uploader/owner details directly in the pet card (similar to social media posts).
- Automatically archive or delete lost pet records after 1–2 months to avoid database clutter.
- Implement email notifications when a match is detected.
- Add a direct chat interface between the pet owner and the person who found the pet.
- Provide a “My Pets” section so users can manage and edit their own uploaded pet records.


## Screenshots

### Login Screen
![Login](./login.jpg)

### Add Lost Pet
![Add Lost Pet](./lost_pet.jpg)

### Matches Screen
![Matches](./matches.jpg)
