# app.py

from flask import Flask
from flask_restful import Api
from resources.auth import SignupResource, LoginResource, GoogleSignInResource
from resources.user import UserProfileResource
from resources.event import EventListResource, EventResource
from resources.message import MessageListResource, SendMessageResource
from resources.notification import NotificationListResource, MarkAsReadResource
from resources.feedback import SubmitFeedbackResource
from flask_jwt_extended import JWTManager

app = Flask(__name__)

# Configuration
app.config['SECRET_KEY'] = 'your-secret-key'  # Replace with your actual secret key
app.config['JWT_SECRET_KEY'] = 'your-jwt-secret-key'  # Replace with your JWT secret key
app.config['PROPAGATE_EXCEPTIONS'] = True

api = Api(app)
jwt = JWTManager(app)

# Authentication Endpoints
api.add_resource(SignupResource, '/api/auth/signup')
api.add_resource(LoginResource, '/api/auth/login')
api.add_resource(GoogleSignInResource, '/api/auth/google-signin')

# User Profile Endpoints
api.add_resource(UserProfileResource, '/api/profiles/<string:user_id>')

# Event Endpoints
api.add_resource(EventListResource, '/api/events')
api.add_resource(EventResource, '/api/events/<string:event_id>')

# Messaging Endpoints
api.add_resource(MessageListResource, '/api/conversations/<string:conversation_id>/messages')
api.add_resource(SendMessageResource, '/api/messages')

# Notification Endpoints
api.add_resource(NotificationListResource, '/api/notifications')
api.add_resource(MarkAsReadResource, '/api/notifications/<string:notification_id>/read')

# Feedback Endpoints
api.add_resource(SubmitFeedbackResource, '/api/feedback')

if __name__ == '__main__':
    app.run(debug=True)
