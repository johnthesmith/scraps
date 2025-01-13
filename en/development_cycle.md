# Development Cycle

[ru](../ru/README.md)

![Development Cycle](https://github.com/johnthesmith/scraps/blob/main/images/development_cycle.png)

## Sequence
1. The initiator describes the task.
2. The developer creates a new branch exclusively from the master branch.
3. The developer works on the task in their branch.
4. Once development is completed, the task moves to the CodeReview stage.
5. The tech lead squashes all developer commits into a single commit A and performs a CodeReview.
6. The tech lead pushes commit A to the dev branch.
7. The task transitions to the testing phase.
8. After testing, the task is either returned for further development or approved.
9. The tech lead pushes only commit A to the master branch, ensuring the tested changes are identical to the deployed ones.
10. The project manager (or another authorized person) performs the release based on the completed development.

## Rules
1. Developers must branch only from the master branch.
2. Only the tech lead pushes to the dev branch.
3. The dev branch is temporary and can be updated from the master branch at any time by the tech lead.
4. The dev branch may be regularly updated from the master branch according to the schedule.
5. Clients work exclusively on the prod server.
6. Developers have access to preprod and dev servers for their work.
7. The prod and master branches are modified only as per the described procedure.

## Recommended Automation Points
1. Creating a new branch for the task (developer).
2. Squashing developer commits into commit A (tech lead).
3. Pushing commit A to the dev branch and rebuilding the dev server (tech lead).
4. Pushing commit A to the master branch and rebuilding the preprod server (tech lead).
5. Releasing from the master branch to the prod branch with a rebuild of the prod server (project manager).

## Advantages
1. Multiple developers can work on the project simultaneously with minimal interference.
2. Simple rollback of accumulated errors in the dev branch.
3. Ensures code integrity in the project.
4. Clear separation of work zones across servers.
5. Minimizes the number of required servers.
6. Full alignment of development stages with technical operations.
7. Unified cycle for development and production stages.

## Note
1. The prod server may be absent during the development stage.
