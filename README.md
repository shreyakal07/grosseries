<img alt="Grosseries logo" src="https://user-images.githubusercontent.com/71287285/231605613-35f9c6d9-82b4-4790-b75f-b4b5445b30b9.png" height=100>

# Grosseries
### Eat your groceries before they become gross-eries 😉🍎

## 👋 Meet Grosseries
Grosseries is an app that acts as a personal food organizer. Users can easily keep track of food items in their kitchen by adding them into a list. Items can be added, searched, edited, deleted, sorted, and filtered. They are also tagged with different attributes/categories based on their expiration date, storage location, quantity, and user(s) who own them.

The app is integrated with a multi-label image classification machine learning (ML) model that allows users to add several items with photos. Users can either take a photo or upload one from the gallery, and the model will return a list of items that were found in the image. This allows users to add many items to their list at once, saving time and effort. 

## 👥 Personas
We started off with user and product research and created 3 personas from what we've gathered to empathize with our users and gain an understanding of their specific goals, motivations, and frustrations. Throughout the project, we referred back to these personas to ensure we were staying on track and fulfilling their needs.  
  
![persona - denise](https://user-images.githubusercontent.com/71287285/231613858-b628d731-2434-458c-ab7d-ca80ffb95a73.png)
![persona - mary](https://user-images.githubusercontent.com/71287285/231613915-92c8b36d-5ebe-4d01-b9b7-388b18b70098.png)
![image](https://user-images.githubusercontent.com/71287285/231613955-ad3210d9-3e67-4218-8b96-bead339e6569.png)
  
## ✏️ Wireframes
We then created low fidelity wireframes in Figma, and this is where we built out our idea and planned how the user experience and navigation would look like. A few of our wireframes are included below: 
  
![add item wireframe part 1](https://user-images.githubusercontent.com/71287285/231607582-aaa914dc-565d-45c3-a240-2a9d4f693266.png)
![add item wireframe part 2](https://user-images.githubusercontent.com/71287285/231607604-6231a1bc-cdbc-428b-8ecb-bf7709539b76.png)
<img alt="create and login wireframes" src="https://user-images.githubusercontent.com/71287285/231606715-3ecee418-d13d-449a-b235-3d0b90ee87d4.png" height=400>
<img alt="notifications wireframes" src="https://user-images.githubusercontent.com/71287285/231607069-1d5c3da7-9336-46f7-b2e5-77033f41342a.png" height=400>

## 📝 Software Architecture Diagram
Next we mapped out the classes, methods, and components we would need in a software architecture diagram and decided upon a Model-View-ViewModel (MVVM) design pattern to separate our business logic from the UI and improve maintainability.  
  
![models and viewmodels](https://user-images.githubusercontent.com/71287285/231617036-7ba5cb7c-3ced-4ea5-a5a0-6e7cfc0389c3.png)
![views](https://user-images.githubusercontent.com/71287285/231617530-72c6c35f-0b7c-4238-ad6f-41d33d3fb624.png)
![components](https://user-images.githubusercontent.com/71287285/231617595-b4e34db6-7b2e-4c28-9843-916fb12aa355.png)
  
## 📱Flutter Application
Next we used Flutter and Dart to implement our plan with Model-View-ViewModel (MVVM) architecture. We faced several challenges throughout the development process including time constraints, sorting and filtering items, and the sliding animation for deleting an item on the home page, but we eventually were able to create a fully functioning minimum viable product (MVP) of our app. 

### Welcome, Create Account, Login: 
  
<img alt="Welcome page" src="https://user-images.githubusercontent.com/71287285/231608033-d195c022-7f6a-4bc2-be5d-749c6200a335.png" height=500> <img alt="Create Account page" src="https://user-images.githubusercontent.com/71287285/231608044-fb83e282-af45-4b1b-bb3f-d1a27da03bc4.png" height=500> <img alt="Login page" src="https://user-images.githubusercontent.com/71287285/231608050-26b54ae8-29c3-4cd3-a980-2417b5da74e4.png" height=500>
  
### Main Page + Item Details + Sorting, Filtering, and Sharing in text form:  
  
<img alt="Main Page" src="https://user-images.githubusercontent.com/71287285/231608064-c0dd37c6-9387-47a0-8ea0-bb9ebd15eca4.png" height=550> <img alt="Item Details" src="https://user-images.githubusercontent.com/71287285/231608363-0b6acd8f-d998-4e75-849b-514c1370c70e.png" height=550> <img alt="deleting item" src="https://user-images.githubusercontent.com/71287285/231619531-4363d690-36ec-4c3c-8e38-645282faac95.png" height=550>  
  
<img alt="Sort Feature" src="https://user-images.githubusercontent.com/71287285/231608116-43fa36d1-cfe2-4bb0-a758-12e55051d635.png" height=550> <img alt="Filter Feature" src="https://user-images.githubusercontent.com/71287285/231608122-03c8f0e7-0879-4f9c-af75-14650eb02af1.png" height=550> <img alt="Share Feature" src="https://user-images.githubusercontent.com/71287285/231608146-b0b5acf3-a0f5-4f6d-a6c4-14d1439bda85.png" height=550> 
  
### Adding Item:  
  
<img alt="Add Item Bottom Sheet" src="https://user-images.githubusercontent.com/71287285/231608689-8c292efd-e926-43f1-be03-822ea73a776f.png" height=550> <img alt="Item Categories" src="https://user-images.githubusercontent.com/71287285/231608726-313dfe1f-7e86-42ce-9c42-105c173530f6.png" height=550> <img alt="Search Item" src="https://user-images.githubusercontent.com/71287285/231608741-b248d5e6-02c0-4e40-85df-465df718398a.png" height=550> <img alt="Select Item" src="https://user-images.githubusercontent.com/71287285/231608753-262cd642-7df1-4d74-a42c-abf51f457473.png" height=550> <img alt="Edit Item Details" src="https://user-images.githubusercontent.com/71287285/231608827-d91f1bed-3bc3-45d7-9790-fe03231c89a6.png" height=550> 
  
### Profile Information: 
  
<img alt="Profile" src="https://user-images.githubusercontent.com/71287285/231609120-b2667cae-6913-431b-904f-2361b3f1eba9.png" height=550> <img alt="Edit Profile" src="https://user-images.githubusercontent.com/71287285/231609140-8dc3a9bb-2d1d-4a23-b7d8-cb50f23f8820.png" height=550> <img alt="Manage Notifications" src="https://user-images.githubusercontent.com/71287285/231609158-b237ef3f-6b3e-4175-8494-6ee2a3bf3c73.png" height=550> 

## 🧠 Adding Machine Learning for a Bulk Add Feature
We then decided to add machine learning to our app and give users the ability to add multiple items at a time. This way, they don't have to individually input items, which can be time consuming and annoying after you've just gotten back to the grocery store. We planned this new feature out in a wireframe:   
  
![bulk add wireframe](https://user-images.githubusercontent.com/71287285/231610342-2e97ca21-5441-4e38-8723-a34193f981c3.png)
  
And we trained a multi-label classification model in Vertex AI that would identify food items in an image. We had some trouble with the model not being able to label multiple food items in an image, but with some additional data and changes to our confidence threshold, we were able to get a MVP of it working.   
  
![model labels](https://user-images.githubusercontent.com/71287285/231610835-957450a0-1943-4980-a7a3-f8d338400baa.png)
![labels accuracy](https://user-images.githubusercontent.com/71287285/231610841-32db6b65-4d08-439f-9109-6901119fcdc6.png)

We added the feature to our app and connected the two together using a Vertex API call. From the Add Item bottom sheet, they can choose to bulk add, which leads them to the page in the following image. There, they can take a photo or upload from gallery. Afterwards, the model gets called and if successful, it returns a list of items that were found in the image. Users can verify whether the items are correct and then add it, where it will then appear in their list. If unsuccessful, an error page appears, and users can try again or manually add their item. 
  
<img alt="Bulk add page" src="https://user-images.githubusercontent.com/71287285/231610979-e5a01fa5-c895-45c2-a8d0-d2986d0c2e8f.png" height=550> <img alt="Error page" src="https://user-images.githubusercontent.com/71287285/231611032-f8b5dacb-9f97-4866-b792-56cf1f63a956.png" height=550>   
<img alt="Bulk add results" src="https://user-images.githubusercontent.com/71287285/231611006-714d12be-7fd4-42f6-913d-00e00220969a.png" height=550> <img alt="Items added successfully" src="https://user-images.githubusercontent.com/71287285/231611022-27c567e7-5106-4572-88bd-5d60b21e7fa2.png" height=550>   

### 👣 Future Steps
In future iterations of this project, we would like to add the ability for users to edit items retrieved from the model so they can change the quantity, location stored, etc. We would also like for users to have the ability to enter an expiration date if they need it and expand our database of items. Another possible feature we have considered adding is the ability for users to joina household so families, roommates, etc. can collectively view and edit what they have in their homes.  

## ❤️ Contributors
* Alexander Grattan
* Shresta Kalla
* Shreya Kalla
* Crystal Li
* Jennifer Zheng



