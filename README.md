## How to Programmatically REQUEST Data from the Login Microservice

Step-by-Step Instructions:
1.	Send a POST request to the /login endpoint of the microservice.
2.	Set the request Content-Type header to application/json.
3.	Include a JSON body with two keys: "username" and "password".

Required Fields in the Request Body:
```
{
  "username": "your_username_here",
  "password": "your_password_here"
}
```

Example Request Call in Python
```
import requests

# Replace this with the actual host/port if deployed
url = "http://localhost:5000/login"

payload = {
    "username": "jdoe",
    "password": "SuperSecret123!"
}

headers = {
    "Content-Type": "application/json"
}

response = requests.post(url, json=payload, headers=headers)
```


## How to Programmatically RECEIVE Data from the Microservice

Step-by-Step Instructions:
1.	Check the HTTP status code in the response to determine if the request was successful.
2.	Parse the JSON response body using your preferred programming language.

Example Handling Response (Python)

```
if response.status_code == 200:
    data = response.json()
    print("✅ Login succeeded:", data["message"])
    print("Session Token:", data["token"])
elif response.status_code == 401:
    print("❌ Login failed:", response.json()["message"])
elif response.status_code == 400:
    print("⚠️ Bad request:", response.json()["message"])
else:
    print("🔴 Unexpected error:", response.status_code)
```

![A_UML_component_diagram_depicts_a_microservice_arc](https://github.com/user-attachments/assets/ec68ba84-91da-42d8-83cd-8abafeb7b704)

