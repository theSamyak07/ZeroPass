import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    // Run tests sequentially — the contract tests thread shared state
    // manually between calls and must NOT be parallelised.
    pool: 'forks',
    poolOptions: {
      forks: {
        singleFork: true,
      },
    },
    // Increase timeout for ZK circuit compilation & proof steps
    testTimeout: 60_000,
    hookTimeout: 30_000,
    // Reporters
    reporters: ['verbose'],
    // Coverage (opt-in: run with --coverage)
    coverage: {
      provider: 'v8',
      reporter: ['text', 'lcov', 'html'],
      include: ['src/**/*.ts'],
      exclude: ['src/**/*.d.ts', 'src/setup.ts'],
    },
  },
});
