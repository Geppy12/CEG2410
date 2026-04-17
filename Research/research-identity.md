# Identity & Policy Management Research

## 1. Enterprise Identity Provider (IdP)

### Selected Platform: Microsoft Entra ID





### Platform Information

- **Name:** Microsoft Entra ID (formerly Azure Active Directory)  
- **Controlling Vendor:** Microsoft  
- **Description:**  
  Microsoft Entra ID is a cloud-based identity and access management (IAM) platform that serves as a centralized "source of truth" for user identities, authentication, and authorization across enterprise systems. It supports Single Sign-On (SSO), Multi-Factor Authentication (MFA), and conditional access policies.

- **Link:**  
  https://entra.microsoft.com/



### Dependencies for Implementation

- Microsoft tenant (Azure/Entra environment)  
- Internet connectivity (cloud-based system)  
- Directory synchronization tool (e.g., Azure AD Connect for hybrid environments)  
- Integration with apps (SaaS, on-prem apps via SSO/SAML/OAuth)



### Cost to Implement

- **Free Tier:** Basic identity management  
- **Paid Tiers:**  
  - P1: ~$6/user/month  
  - P2: ~$9/user/month  
- Additional costs may include:
  - Licensing bundles (Microsoft 365 E3/E5)  
  - Infrastructure for hybrid environments  



### Pricing Model

- Subscription-based (per user/month)  
- Tiered licensing (Free, P1, P2)



### Scalability

- Highly scalable (supports small businesses to global enterprises)  
- Handles millions of users and identities  
- Cloud-native architecture allows elastic scaling



### Implementation Needs

- Admin account setup  
- Domain verification  
- User provisioning (manual or automated sync)  
- Application integration (SSO configuration)



### What Administrators Enter

- User identities (name, email, roles)  
- Group assignments  
- Access roles and permissions  
- Device compliance policies  



### Policy Management

- Conditional Access Policies:
  - Location-based access  
  - Device compliance checks  
  - Risk-based authentication  
- Security defaults (baseline protection)



### Access Management

- Role-Based Access Control (RBAC)  
- Single Sign-On (SSO)  
- Application-level permissions  
- Privileged Identity Management (PIM)



### Account Configuration

- User creation (manual or automated)  
- Group-based access assignment  
- Password policies  
- MFA enforcement settings  



## 2. MFA & Verification Methods

### Selected Category: Hardware-Based Authentication



### 1. YubiKey

- **Description:**  
  A physical security key that supports FIDO2/WebAuthn for passwordless authentication and strong MFA. Users plug it into USB or tap via NFC.

- **Link:**  
  https://www.yubico.com/

- **Dependencies:**
  - Compatible systems (browser + OS support)  
  - Identity provider integration (e.g., Entra ID, Okta)  
  - USB/NFC access  

- **Cost to Implement:**
  - Device cost: ~$25–$70 per key  
  - Optional backup keys recommended  
  - Minimal ongoing cost  



### 2. Smartcards (PIV/CAC)

- **Description:**  
  Physical cards used for authentication in government and enterprise systems. Require insertion into a reader and use cryptographic certificates.

- **Link:**  
  https://www.idmanagement.gov/

- **Dependencies:**
  - Smartcard reader hardware  
  - PKI infrastructure (certificate authority)  
  - Middleware/software drivers  

- **Cost to Implement:**
  - Card: ~$10–$50 per user  
  - Reader: ~$20–$100 per device  
  - Infrastructure (PKI setup can be expensive)  


## 3. High-Level Research Theme

### Selected Category: Deepfake Defense



### What is the Concern

Deepfake technology uses AI to create highly realistic fake videos, audio, or biometric data. This poses a serious risk to identity verification systems, especially those relying on facial recognition or voice authentication.



### Is It Currently Being Exploited?

Yes — current exploitation includes:

- Fake video identities to bypass KYC (Know Your Customer)  
- Voice cloning used in social engineering attacks  
- AI-generated faces used to create fake accounts  



### Methods for Exploitation

- Generative AI models (GANs, diffusion models)  
- Voice synthesis tools  
- Real-time face swapping software  



### Response to Prevent Exploitation

- **Liveness Detection:**  
  Ensures the user is physically present (blinking, movement checks)

- **Multi-Factor Authentication (MFA):**  
  Combines biometrics with additional verification layers  

- **Behavioral Analysis:**  
  Tracks typing patterns, device usage, and anomalies  

- **AI Detection Tools:**  
  Systems trained to detect deepfake artifacts  



## Summary

Identity and access management is evolving rapidly. Platforms like Microsoft Entra ID provide scalable identity control, while hardware MFA solutions like YubiKeys strengthen authentication. Emerging threats such as deepfakes are pushing organizations toward continuous verification and more advanced security mechanisms.
