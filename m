From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Thu, 4 Oct 2018 04:17:19 +1000 (AEST)
Message-ID: <alpine.LRH.2.21.1810040416500.13517@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org> <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com> <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
 <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com> <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com> <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com> <alpine.LRH.2.21.1810030758460.23596@namei.org>
 <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com> <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 2 Oct 2018, John Johansen wrote:

> To me a list like
>   lsm.enable=X,Y,Z

What about even simpler:

lsm=selinux,!apparmor,yama

> 
> is best as a single explicit enable list, and it would be best to avoid
> lsm.disable as it just introduces confusion.
> 
> I do think per-LSM bootparams looses the advantages of centralization,
> and still requires the user to know some Kconfig info but it also gets
> rid of the lsm.disable confusion.
> 
> With ordering separated out from being enabled there is a certain
> cleanness to it. And perhaps most users are looking to enable/disable
> a single lsm, instead of specifying exactly what security they want
> on their system.
> 
> If we were to go this route I would rather drop the lsm. prefix
> 
> 
> > I think the current proposal (in the other thread) is likely the
> > sanest approach:
> > 
> > - Drop CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE
> > - Drop CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE
> > - All enabled LSMs are listed at build-time in CONFIG_LSM_ENABLE
> 
> Hrrmmm isn't this a Kconfig selectable list, with each built-in LSM
> available to be enabled by default at boot.
> 
> > - Boot time enabling for selinux= and apparmor= remain
> > - lsm.enable= is explicit: overrides above and omissions are disabled
> wfm
> 
> > - maybe include lsm.disable= to disable anything
> 

-- 
James Morris
<jmorris@namei.org>
