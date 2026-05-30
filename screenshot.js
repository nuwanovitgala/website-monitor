const puppeteer = require('puppeteer');

(async () => {
    const url = process.argv[2];
    const output = process.argv[3];

    const browser = await puppeteer.launch({
        headless: "new",
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();

    await page.setViewport({
        width: 1366,
        height: 768
    });

    console.log(`Opening ${url}`);

    await page.goto(url, {
        waitUntil: 'networkidle2',
        timeout: 120000
    });

    // Wait extra time for full rendering
    console.log("Waiting for page rendering...");

    await new Promise(resolve => setTimeout(resolve, 60000));

    // Auto scroll to trigger lazy loading
    await page.evaluate(async () => {
        await new Promise((resolve) => {
            let totalHeight = 0;
            const distance = 500;

            const timer = setInterval(() => {
                window.scrollBy(0, distance);
                totalHeight += distance;

                if (totalHeight >= document.body.scrollHeight) {
                    clearInterval(timer);
                    resolve();
                }
            }, 500);
        });
    });

    // Scroll back to top
    await page.evaluate(() => {
        window.scrollTo(0, 0);
    });

    console.log("Taking screenshot...");

    await page.screenshot({
        path: output,
        fullPage: true
    });

    await browser.close();

    console.log("Screenshot saved:", output);
})();
