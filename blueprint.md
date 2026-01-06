# KrisiBandhu: AI-Powered Crop Insurance

## Overview

KrisiBandhu (formerly CROPIC) is a digital platform designed to make crop insurance claims faster, fairer, and more transparent for farmers in India. By leveraging a mobile app, AI-powered image analysis, and a real-time monitoring dashboard, KrisiBandhu aims to automate and streamline the entire process of crop damage assessment.

## Key Features & Components

The project consists of three main components:

1.  **Mobile App (For Farmers & Officials):** An intuitive Flutter application that allows users to:
    *   Securely log in/sign up.
    *   Capture geotagged and timestamped images of their crops.
    *   Receive guidance for taking high-quality images.
    *   File and track insurance complaints/claims.
    *   Explore relevant insurance schemes.
    *   Manage their user profile.

2.  **AI/ML Cloud Platform (The Brain):** A backend system using Firebase and Google Cloud AI that:
    *   Stores images securely in Cloud Storage.
    *   Manages metadata in Cloud Firestore.
    *   Uses AI/ML models (hosted on Firebase ML or AI Platform) to analyze images for crop type, growth stage, health, and damage.
    *   Triggers analysis automatically using Cloud Functions.

3.  **Web Dashboard (For Authorities):** A web-based interface for officials to:
    *   View a real-time map of crop health and damage reports.
    *   Receive alerts for newly detected issues.
    *   Visualize and manage claim data.

## Style and Design Principles

*   **Theme:** Agriculture-inspired, with a color palette dominated by greens, browns, and yellows to feel familiar and trustworthy.
*   **Typography:** Clean, legible fonts using `google_fonts` for excellent readability on mobile devices.
*   **UI:** Icon-driven, with clear visual cues and minimal text to ensure ease of use for farmers with varying levels of tech literacy.
*   **Layout:** A simple, card-based layout for the dashboard to provide easy access to key features.
*   **Visuals:** Use of relevant, high-quality agricultural images and icons.

## Current Plan: Initial App Setup & Home Page

**Objective:** Create the foundational structure of the Flutter app and build the home page (dashboard).

**Steps:**

1.  **Add Dependencies:** Install `provider` for state management, `go_router` for navigation, and `google_fonts` for typography.
2.  **Project Structure:** Organize the code into a feature-first directory structure (`/lib/src/features/...`).
3.  **Theming:** Implement a custom `ThemeData` with an agriculture-based color scheme and typography.
4.  **Routing:** Configure `go_router` to handle navigation between the login screen and the home dashboard.
5.  **Login UI:** Create a placeholder UI for the login screen.
6.  **Home Page UI:** Design and build the main dashboard screen, which will serve as the app's front page. It will feature a welcoming design and clear, icon-based navigation to the app's main sections.
