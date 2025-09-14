# Boilerplate

This is a streamlined Phoenix boilerplate designed to serve as a minimal starting point for new web applications. It removes unnecessary auto-generated code and provides a clean, opinionated foundation with quality-of-life helpers that make it more lightweight for side projects and rapid development. Unlike the standard Phoenix generator, this boilerplate focuses on simplicity while maintaining the powerful features that make Phoenix great.

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/thiagomajesk/boilerplate.git your_app_name
```

After cloning the repository, you will want to do some cleanup:

- Delete the repository metadata: `rm -rf .git`
- Remove the upstream repository: `git remote remove origin`

### Rename the project

This project includes the `rename_project` dependency. To easily rename the project:

```bash
mix rename Boilerplate YourAppName
```

For any remaining occurrences that might have been missed by the rename mix task, run the following command to find them and manually change them: `git grep -ni "boilerplate"`.
