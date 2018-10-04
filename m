From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Thu, 4 Oct 2018 09:18:40 -0700
Message-ID: <CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com>
References: <20181002005505.6112-1-keescook@chromium.org> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <CAGXu5jLBHN=YSs3Uh49bBJ1SRA1Km2UUD4j37GJJXiKhQq+KPA@mail.gmail.com> <f016c836-cc9d-0a2d-fb18-930b43898cdf@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f016c836-cc9d-0a2d-fb18-930b43898cdf@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 3, 2018 at 10:56 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/03/2018 01:36 PM, Kees Cook wrote:
>> I still think we should have all built LSMs enabled by default, with
>> CONFIG_LSM_DISABLE available to turn stuff off. CONFIG_LSM_ORDER
>
> and this as a distro ubuntu does not want.
> Ubuntu wants to make yes available by building them in, but does NOT
> want all the LSM enabled by default, not even necessarily all minor LSMs.
>
> As a distro we want a supported set as default, and users can opt-in
> to new LSMs. If a new LSM comes along we don't want it enabled by
> default, which happens Using the lsm disable approach.

Okay, but order still matters. Where, in the order, should a disabled
LSM go? It seems like the friendliest approach for an end-user would
be to do something like

lsm=+landlock

and it all works correctly. That user doesn't need to know about
ordering or the distro default LSMs. They just want to _add_ landlock.
They want all the other LSMs to still be present, and they want the
distro to have chosen where landlock is in the ordering.

>> I should also note that I don't want to leave CONFIG_DEFAULT_SECURITY
>> in, since it's just a way to disable all the other majors. I don't
>> like this because it will force LSMs to be disabled that don't need to
>> be once blob-sharing lands. The whole point of this series is to get
>> us away from fixed ordering and thinking about "major" vs "minor" and
>> towards "exclusive" or not, where we can continue to slowly chip away
>> at exclusivity without breaking anything.
>>
> sure we definitely want to get away form "major" vs "minor" and in
> generally even exclusive, except where to LSMs just can't live
> with each other.
>
> But that doesn't mean dropping something like default security. The
> mistake with the current DEFAULT_SECURITY was that it only applied
> to major LSMs, not the minor ones.

Right, we need to expand it to include a full description of ordering
and enablement.

How about this:

CONFIG_LSM specifies order and enablement status. For example:

CONFIG_LSM=yama,loadpin,apparmor,!selinux

This means init order is yama, loadpin, apparmor, selinux, but selinux
is disabled. Anything not listed in CONFIG_LSM but built in will be
disabled and ordered in link-order. (i.e. an implicit trailing
"!smack,!tomoyo".)

Then we add "lsm=" which understands modifiers "-", and "+".
"lsm=-apparmor,+selinux" wouldn't change ordering, but would disable
apparmor and enable selinux. "lsm=smack,loadpin" would enable only
smack and loadpin, in that order and disable everything else.

I don't want to overload "security=", but we can if we want. It would
be as above, but a trailing comma would be needed to trigger the
"ordering" behavior. e.g. "security=selinux" would disable all other
majors (retaining the current behavior), but "security=selinux," would
disable all other LSMs.

-Kees

-- 
Kees Cook
Pixel Security
