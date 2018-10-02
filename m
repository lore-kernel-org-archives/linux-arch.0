From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Tue, 2 Oct 2018 12:47:53 -0700
Message-ID: <125243f2-8532-c0c0-0b0e-d28b3ecb910e@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org>
 <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
 <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com>
 <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 10/02/2018 12:17 PM, Kees Cook wrote:
> On Tue, Oct 2, 2018 at 11:57 AM, John Johansen
> <john.johansen@canonical.com> wrote:
>> Under the current scheme
>>
>> lsm.enabled=selinux
>>
>> could actually mean selinux,yama,loadpin,something_else are
>> enabled. If we extend this behavior to when full stacking lands
>>
>> lsm.enabled=selinux,yama
>>
>> might mean selinux,yama,apparmor,loadpin,something_else
>>
>> and what that list is will vary from kernel to kernel, which I think
>> is harder for the user than the lsm.enabled list being what is
>> actually enabled at boot
> 
> Ah, I think I missed this in your earlier emails. What you don't like
> here is that "lsm.enable=" is additive. You want it to be explicit.
> 
> Are you okay with lsm.order= having fallback?
> 

yeah, if we are going to separate order, fallbacks are fine for
anything that isn't specified.

I am still not convinced that separating order from enablement is
right, but its generally something a user should care about so I can
live with it.

> The situation we were trying to solve was with new LSMs getting
> implicitly disabled if someone is booting with an explicit list. For
> example:
> 
> lsm.enable=yama,apparmor
> 
> means when "landlock" gets added to the kernel, it will be implicitly disabled.
> 

And here is the point of contention, I wouldn't call that implicitly
disabled. The user explicitly selected a set of LSMs to enable. Having
other LSMs enable when they aren't specified is confusing to a user,
as now they have to consider what is enabled by default in the
Kconfig.

I think requiring distros/builders to consider Kconfig options is
fine, but its a lot higher hurdle for regular users.


>> If we have to have multiple kernel parameter, I prefer a behvior where
>> if you hav conflicting kernel parameters specified
>>
>>   apparmor=0 lsm.enabled=apparmor
>>
>> that the conflict is logged and the lsm is left disabled, as I think
>> it is easier for users to understand than the overrides scheme of v3,
>> and sans logging of the conflict is effectively what we had in the
>> past
>>
>>   apparmor=0 security=apparmor
>> or
>>   apparmor=1 security=selinux
>>
>> would result in apparmor being disabed
> 
> Okay, so for this part you want per-LSM boot param to have priority
> (which seems to match SELinux's concerns), possibly logging the

hrmmm I wouldn't call it priority :)

If you look at the above logic its a boolean AND operation. The LSM is
only enabled if $LSM=1 AND security=$LSM all other combinations result
in $LSM being disabled

> conflict, but still accepting the apparmor= and selinux= state.

logging is nice for the user but certainly isn't required and is more
than we are doing today

> security= would still driving initialization ordering (so I think the
> behavior I have in the series would be correct).
> 
>> That being said I get we have a mess currently, and there really
>> doesn't seem to be a good way to fix it. I think getting this right
>> for the user is important enough that I am willing to break current
>> apparmor userspace api. While apparmor=0 is documented we have also
>> documented security=X for years and apparmor=0 isn't used too often
>> so I think we can drop it to help clean this mess up abit.
>>
>> I am not going to Nak, or block on v3 behavior if that is considered
>> the best path forward after this discussion/rant.
> 
> I could define CONFIG_LSM_ENABLE as being "additive" to
> SECURITY_APPARMOR_BOOTPARAM_VALUE and
> SECURITY_SELINUX_BOOTPARAM_VALUE?
> 

Oh sure lets deal with my complaint about too many ways to configure
this beast by adding yet another config option :P

seriously though, please no. That just adds another layer of confusion
even if it is only being foisted on the distro/builder
