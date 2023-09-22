import { promises as fs } from "node:fs";

const { BUILD_WORKSPACE_DIRECTORY } = process.env;

console.log({ BUILD_WORKSPACE_DIRECTORY });
