// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Google Chrome",
  rewrite: [
    // Rewrite Discord URLs so they can be opened in the app
    {
      match: ({ url }) => url.host == "discord.com" && url.pathname.startsWith("/channels"),
      url: {
        host: "discordapp.com",
        protocol: "discord"
      }
    },
    // Rewrite Front URLs so they can be opened in the app
    {
      match: ({ url }) => url.host == "app.frontapp.com" && url.pathname.startsWith("/open"),
      url: ({ url }) => {
        return {
          ...url,
          host: "go",
          protocol: "frontapp",
          pathname: "?link=" + url.pathname,
        }
      }
    }
  ],
  handlers: [
    // P&T Notion links → Notion app
    {
      match: [
        "www.notion.so/pixelandtonic/*",
      ],
      browser: "Notion"
    },
    // Linear URLs → Linear app
    {
      match: [
        "linear.app/craftcms/*",
      ],
      browser: "Linear"
    },
    // rewritten Discord links → Discord app
    {
      match: ({ url, urlString }) => {
        return url.protocol === "discord";
      },
      browser: "Discord Canary"
    },
    // rewritten Front links → Front app
    {
      match: ({ url, urlString }) => {
        return url.protocol === "frontapp";
      },
      browser: "Front"
    }
  ]
}
