From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Wed, 3 Oct 2018 17:03:53 -0700
Message-ID: <CAGXu5jKGtNYXkFQVxOM9M1fdgaZcki6NqfJAtE0_VsG75Ku=HQ@mail.gmail.com>
References: <20181002005505.6112-1-keescook@chromium.org> <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <alpine.LRH.2.21.1810040723320.16168@namei.org> <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
 <6037a1f0-7af1-9847-91f6-6444f04f5b21@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6037a1f0-7af1-9847-91f6-6444f04f5b21@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 3, 2018 at 4:59 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> To me, "security=selinux" means SELinux and nothing else, so I think that
> all of these params are inviting a lot of confusion.
>
> Sorry, I don't have a good answer for this.

This part, at least, has a pretty clear solution. :) The consensus is
to limit "security=" to what have been considered the "major" LSMs" so
it'll work in spirit the way it was designed. The goal of the new
options, though, is to find something that'll fit all the ways LSMs
are getting used: the majors, the minors, and the coming "medium"
LSMs. The precedent is pretty good here, since "security=" already
ignores the minor LSMs: Yama and LoadPin. So it'll just control the
enable/disable of the "major" LSMs, who will carry an internal marking
indicating that they're mediated by "security=" (and no new LSMs would
get this marking).

-Kees

-- 
Kees Cook
Pixel Security
