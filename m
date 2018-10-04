From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Fri, 5 Oct 2018 03:49:14 +1000 (AEST)
Message-ID: <alpine.LRH.2.21.1810050338470.14095@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com> <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com> <alpine.LRH.2.21.1810030758460.23596@namei.org>
 <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com> <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org> <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com> <alpine.LRH.2.21.1810040723320.16168@namei.org> <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: John Johansen <john.johansen@canonical.com>, Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 3 Oct 2018, Kees Cook wrote:

> On Wed, Oct 3, 2018 at 2:34 PM, James Morris <jmorris@namei.org> wrote:
> > On Wed, 3 Oct 2018, Kees Cook wrote:
> >
> >   - All LSMs which are built are NOT enabled by default
> >
> >   - You specify enablement and order via a Kconfig:
> >
> >         CONFIG_LSM="selinux,yama"
> >
> >   - This can be entirely overridden by a boot param:
> >
> >         lsm="apparmor,landlock"
> 
> This doesn't work with how SELinux and AppArmor do their bootparams,
> unfortunately. (And Paul and Stephen have expressed that the
> documented selinux on/off must continue to work.) For example, let's
> say you've built an Ubuntu kernel with:
> 
> CONFIG_SELINUX=y
> ...
> CONFIG_LSM="yama,apparmor"
> 
> (i.e. you want SELinux available, but not enabled, so it's left out of
> CONFIG_LSM)
> 
> Then someone boots the system with:
> 
> selinux=1 security=selinux
> 
> In what order does selinux get initialized relative to yama?
> (apparmor, flagged as a "legacy major", would have been disabled by
> the "security=" not matching it.)

It doesn't, it needs to be specified in one place.

Distros will need to update boot parameter handling for this kernel 
onwards.  Otherwise, we will need to carry this confusing mess forward 
forever.

> The LSM order needs to be defined externally to enablement because 
> something may become enabled when not listed in the order.
> 
> Now, maybe I misunderstood your earlier suggestion, and what you meant
> was to do something like:
> 
> CONFIG_LSM="yama,apparmor,!selinux"
> 
> to mean "put selinux here in the order, but don't enable it". Then the
> problem becomes what happens to an LSM that has been built in but not
> listed in CONFIG_LSM?

In my most recent suggestion, there is no '!' disablement, just 
enablement.  If an LSM is not listed in CONFIG_LSM="", it's not enabled.

> Related to that, this means that when new LSMs are added, they will
> need to be added to any custom CONFIG_LSM= or lsm= parameters. If
> that's really how we have to go, I'll accept it, but I think it's a
> bit unfriendly. :P

If you want to enable them, yes.  How is this different to adding new 
mount options as new fs features become available?


> Another reason I don't like it is because it requires users to know
> about all the LSMs to make changes. One LSM can't be added/removed
> without specifying ALL of the LSMs. (i.e. there is no trivial way to
> enable/disable a single LSM without it growing its own enable/disable
> code as in SELinux/AppArmor. I'd hoped to make that easier for both
> users and developers.) Again, I can live with it, but I think it's
> unfriendly.

This is only done via boot params or KConfig.

-- 
James Morris
<jmorris@namei.org>
