import { test, expect } from '@playwright/test';

test.describe('Website Smoke Tests', () => {
  test('homepage loads and has content', async ({ page }) => {
    await page.goto('/');
    await expect(page).toHaveTitle(/.*richardjm.*/i);
    await expect(page.locator('main, [role="main"]')).toBeVisible();
  });

  test('navigation bar is visible', async ({ page }) => {
    await page.goto('/');
    const nav = page.getByRole('navigation', { name: 'Main' });
    await expect(nav).toBeVisible();
  });

  test('docs intro page loads', async ({ page }) => {
    await page.goto('/docs/intro');
    await expect(page.locator('h1')).toBeVisible();
  });

  test('blog page loads', async ({ page }) => {
    await page.goto('/blog');
    await expect(page.locator('main, [role="main"]')).toBeVisible();
  });

  test('3d-printing section loads', async ({ page }) => {
    await page.goto('/docs/3d-printing');
    await expect(page.locator('h1')).toBeVisible();
  });

  test('links are navigable', async ({ page }) => {
    await page.goto('/');
    const link = page.locator('a').first();
    await expect(link).toBeVisible();
    const href = await link.getAttribute('href');
    expect(href).toBeTruthy();
  });

  test('no console errors on homepage', async ({ page }) => {
    const errors: string[] = [];
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });
    await page.goto('/');
    expect(errors.length).toBe(0);
  });
});
