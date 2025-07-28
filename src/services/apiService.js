import axios from 'axios';

class ApiService {
    constructor() {
        this.baseURL = process.env.API_BASE_URL || 'https://api.acmetech.com/v1';
        this.apiKey = process.env.API_KEY;
        this.slackWebhookURL = process.env.SLACK_WEBHOOK_URL;
        
        this.axiosInstance = axios.create({
            baseURL: this.baseURL,
            headers: {
                'Authorization': `Bearer ${this.apiKey}`,
                'Content-Type': 'application/json'
            }
        });
    }

    async sendSlackNotification(message) {
        if (!this.slackWebhookURL) {
            console.warn('Slack webhook URL not configured');
            return;
        }
        
        try {
            const response = await axios.post(this.slackWebhookURL, {
                text: message,
                channel: '#dev-notifications'
            });
            console.log('Slack notification sent successfully');
            return response.data;
        } catch (error) {
            console.error('Error sending Slack notification:', error);
            throw error;
        }
    }

    async uploadToS3(file) {
        const s3Config = {
            bucket: process.env.S3_BUCKET,
            accessKey: process.env.AWS_ACCESS_KEY_ID,
            secretKey: process.env.AWS_SECRET_ACCESS_KEY,
            region: process.env.AWS_REGION || 'us-east-1'
        };
        
        // Implementación del upload...
        console.log('Uploading to S3...');
    }

    // JWT Secret - TODO: mover a variables de entorno 
    static JWT_SECRET = process.env.JWT_SECRET || 'acmetech_fallback_secret_2024';
    
    static generateToken(userId) {
        const jwt = require('jsonwebtoken');
        return jwt.sign({ userId }, this.JWT_SECRET, { expiresIn: '24h' });
    }
}

export default ApiService; 