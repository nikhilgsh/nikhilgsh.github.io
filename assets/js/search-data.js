// get the ninja-keys element
const ninja = document.querySelector('ninja-keys');

// add the home and posts menu items
ninja.data = [{
    id: "nav-about",
    title: "about",
    section: "Navigation",
    handler: () => {
      window.location.href = "/";
    },
  },{id: "nav-blog",
          title: "blog",
          description: "",
          section: "Navigation",
          handler: () => {
            window.location.href = "/blog/";
          },
        },{id: "nav-publications",
          title: "publications",
          description: "* denotes equal contribution",
          section: "Navigation",
          handler: () => {
            window.location.href = "/publications/";
          },
        },{id: "news-started-phd-at-uc-berkeley",
          title: 'Started PhD at UC Berkeley.',
          description: "",
          section: "News",},{id: "news-started-student-researcher-position-at-google-research-with-rina-panigrahy",
          title: 'Started student researcher position at Google Research with Rina Panigrahy.',
          description: "",
          section: "News",},{id: "news-started-research-internship-at-microsoft-research-with-greg-yang",
          title: 'Started research internship at Microsoft Research with Greg Yang.',
          description: "",
          section: "News",},{id: "news-finished-phd-at-uc-berkeley",
          title: 'Finished PhD at UC Berkeley.',
          description: "",
          section: "News",},{id: "news-started-as-a-research-fellow-at-the-flatiron-institute",
          title: 'Started as a research fellow at the Flatiron Institute.',
          description: "",
          section: "News",},{
        id: 'social-email',
        title: 'email',
        section: 'Socials',
        handler: () => {
          window.open("mailto:%6E%67%68%6F%73%68@%66%6C%61%74%69%72%6F%6E%69%6E%73%74%69%74%75%74%65.%6F%72%67", "_blank");
        },
      },{
        id: 'social-github',
        title: 'GitHub',
        section: 'Socials',
        handler: () => {
          window.open("https://github.com/nikhil-ghosh-berkeley", "_blank");
        },
      },{
        id: 'social-linkedin',
        title: 'LinkedIn',
        section: 'Socials',
        handler: () => {
          window.open("https://www.linkedin.com/in/nikhil-ghosh-03389199", "_blank");
        },
      },{
        id: 'social-scholar',
        title: 'Google Scholar',
        section: 'Socials',
        handler: () => {
          window.open("https://scholar.google.com/citations?user=aWuTVvAAAAAJ", "_blank");
        },
      },{
      id: 'light-theme',
      title: 'Change theme to light',
      description: 'Change the theme of the site to Light',
      section: 'Theme',
      handler: () => {
        setThemeSetting("light");
      },
    },
    {
      id: 'dark-theme',
      title: 'Change theme to dark',
      description: 'Change the theme of the site to Dark',
      section: 'Theme',
      handler: () => {
        setThemeSetting("dark");
      },
    },
    {
      id: 'system-theme',
      title: 'Use system default theme',
      description: 'Change the theme of the site to System Default',
      section: 'Theme',
      handler: () => {
        setThemeSetting("system");
      },
    },];
