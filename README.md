# Boilerplate

This is a streamlined Phoenix boilerplate designed to serve as a minimal starting point for new web applications. It removes unnecessary auto-generated code and provides a clean, opinionated foundation with quality-of-life helpers that make it more lightweight for side projects and rapid development. Unlike the standard Phoenix generator, this boilerplate focuses on simplicity while maintaining the powerful features that make Phoenix great.

## Getting Started

### 1. Clone the Repository

```bash
git clone https://thiagomajesk/boilerplate.git your_app_name
```

### 2. Rename the Project

This your_app_name includes the `rename_project` dependency to easily rename the project:

```bash
mix rename Boilerplate YourAppName
```

### 3. Additional Cleanup

For any remaining occurrences that might have been missed by the rename task, run this command to find them and manually rename them:

```bash
git grep -ni "boilerplate"
```
