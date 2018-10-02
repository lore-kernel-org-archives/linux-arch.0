From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Tue, 2 Oct 2018 16:06:25 -0700
Message-ID: <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.21.1810030758460.23596@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>, Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 2, 2018 at 3:06 PM, James Morris <jmorris@namei.org> wrote:
> On Tue, 2 Oct 2018, Kees Cook wrote:
>
>> On Tue, Oct 2, 2018 at 11:57 AM, John Johansen
>> <john.johansen@canonical.com> wrote:
>> > Under the current scheme
>> >
>> > lsm.enabled=selinux
>> >
>> > could actually mean selinux,yama,loadpin,something_else are
>> > enabled. If we extend this behavior to when full stacking lands
>> >
>> > lsm.enabled=selinux,yama
>> >
>> > might mean selinux,yama,apparmor,loadpin,something_else
>> >
>> > and what that list is will vary from kernel to kernel, which I think
>> > is harder for the user than the lsm.enabled list being what is
>> > actually enabled at boot
>>
>> Ah, I think I missed this in your earlier emails. What you don't like
>> here is that "lsm.enable=" is additive. You want it to be explicit.
>>
>
> This is a path to madness.
>
> How about enable flags set ONLY per LSM:
>
> lsm.selinux.enable=x
> lsm.apparmor.enable=x
>
> With no lsm.enable, and removing selinux=x and apparmor=x.
>
> Yes this will break existing docs, but they can be updated for newer
> kernel versions to say "replace selinux=0 with lsm.selinux.enable=0" from
> kernel X onwards.
>
> Surely distro packages and bootloaders are able to cope with changes to
> kernel parameters?
>
> We can either take a one-time hit now, or build new usability debt, which
> will confuse people forever.

I'd like to avoid this for a few reasons:

- this requires per-LSM plumbing instead of centralized plumbing
  - each LSM needs to have its own CONFIG flag
  - each LSM needs to have its own bootparam flag
- SELinux has explicited stated they do not want to lose selinux=
- this doesn't meet John's goal of having a "single explicit enable list"

I think the current proposal (in the other thread) is likely the
sanest approach:

- Drop CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE
- Drop CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE
- All enabled LSMs are listed at build-time in CONFIG_LSM_ENABLE
- Boot time enabling for selinux= and apparmor= remain
- lsm.enable= is explicit: overrides above and omissions are disabled
- maybe include lsm.disable= to disable anything

-Kees

-- 
Kees Cook
Pixel Security
