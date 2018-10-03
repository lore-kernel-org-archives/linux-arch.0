From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Wed, 3 Oct 2018 13:36:09 -0700
Message-ID: <CAGXu5jLBHN=YSs3Uh49bBJ1SRA1Km2UUD4j37GJJXiKhQq+KPA@mail.gmail.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>, Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 3, 2018 at 1:10 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Oct 3, 2018 at 11:28 AM, James Morris <jmorris@namei.org> wrote:
>> On Wed, 3 Oct 2018, Kees Cook wrote:
>>
>>> On Wed, Oct 3, 2018 at 11:17 AM, James Morris <jmorris@namei.org> wrote:
>>> > On Tue, 2 Oct 2018, John Johansen wrote:
>>> >> To me a list like
>>> >>   lsm.enable=X,Y,Z
>>> >
>>> > What about even simpler:
>>> >
>>> > lsm=selinux,!apparmor,yama
>>>
>>> We're going to have lsm.order=, so I'd like to keep it with a dot
>>> separator (this makes it more like module parameters, too). You want
>>> to mix enable/disable in the same string? That implies you'd want
>>> implicit enabling (i.e. it complements the builtin enabling), which is
>>> opposite from what John wanted.
>>>
>>
>> Why can't this be the order as well?
>
> That was covered extensively in the earlier threads. It boils down to
> making sure we do not create a pattern of leaving LSMs disabled by
> default when they are added to the kernel. The v1 series used
> security= like this:
>
> +       security=       [SECURITY] An ordered comma-separated list of
> +                       security modules to attempt to enable at boot. If
> +                       this boot parameter is not specified, only the
> +                       security modules asking for initialization will be
> +                       enabled (see CONFIG_DEFAULT_SECURITY). Duplicate
> +                       or invalid security modules will be ignored. The
> +                       capability module is always loaded first, without
> +                       regard to this parameter.
>
> This meant booting "security=apparmor" would disable all the other
> LSMs, which wasn't friendly at all. So "security=" was left alone (to
> leave it to only select the "major" LSM: all major LSMs not matching
> "security=" would be disabled). So I proposed "lsm.order=" to specify
> the order things were going to be initialized in, but to avoid kernels
> booting with newly added LSMs forced-off due to not being listed in
> "lsm.order=", it had to have implicit fall-back for unlisted LSMs.
> (i.e. anything missing from lsm.order would then follow their order in
> CONFIG_LSM_ORDER, and anything missing there would fall back to
> link-time ordering.) However, then the objection was raised that this
> didn't provide a way to explicitly disable an LSM. So I proposed
> lsm.enable/disable, and John argued for CONFIG_LSM_ENABLE over
> CONFIG_LSM_DISABLE.

I still think we should have all built LSMs enabled by default, with
CONFIG_LSM_DISABLE available to turn stuff off. CONFIG_LSM_ORDER
declares their order, "lsm.order=" works as mentioned, and
"lsm.enable/disable=" make changes to what's enabled.

(This would be most like the v3 series, swapping CONFIG_LSM_ENABLE for
CONFIG_LSM_DISABLE.)

It gives us centralized ordering and centralized disabling. Distros
wanting specific LSMs are already building them, so _also_ adding them
to CONFIG_LSM_ENABLE seems redundant to me. Distros wanting all the
LSMs just want to declare the order of initialization, and maybe add
some to CONFIG_LSM_DISABLE some day, so they use CONFIG_LSM_ORDER.

I should also note that I don't want to leave CONFIG_DEFAULT_SECURITY
in, since it's just a way to disable all the other majors. I don't
like this because it will force LSMs to be disabled that don't need to
be once blob-sharing lands. The whole point of this series is to get
us away from fixed ordering and thinking about "major" vs "minor" and
towards "exclusive" or not, where we can continue to slowly chip away
at exclusivity without breaking anything.

-Kees

-- 
Kees Cook
Pixel Security
