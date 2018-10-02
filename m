From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Tue, 2 Oct 2018 11:57:41 -0700
Message-ID: <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org>
 <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
 <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Jordan Glover <Golden_Miller83@protonmail.ch>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 10/02/2018 09:54 AM, Kees Cook wrote:
> On Tue, Oct 2, 2018 at 9:33 AM, Jordan Glover
> <Golden_Miller83@protonmail.ch> wrote:
>> It's always documented as: "selinux=1 security=selinux" so security= should
>> still do the job and selinux=1 become no-op, no?
> 
> The v3 patch set worked this way, yes. (The per-LSM enable defaults
> were set by the LSM. Only in the case of "lsm.disable=selinux" would
> the above stop working.)
> 
> John did not like the separation of having two CONFIG and two

still don't

> bootparams mixing the controls. The v3 resolution rules were:
> 
> SECURITY_SELINUX_BOOTPARAM_VALUE overrides CONFIG_LSM_ENABLE.
> SECURITY_APPARMOR_BOOTPARAM_VALUE overrides CONFIG_LSM_ENABLE.
> selinux= overrides SECURITY_SELINUX_BOOTPARAM_VALUE.
> apparmor.enabled= overrides SECURITY_APPARMOR_BOOTPARAM_VALUE.
> apparmor= overrides apparmor.enabled=.
> lsm.enable= overrides selinux=.
> lsm.enable= overrides apparmor=.
> lsm.disable= overrides lsm.enable=.
> major LSM _omission_ from security= (if present) overrides lsm.enable.
> 

Yeah I would really like to remove the potential confusion for the
user. The user now has 4 kernel options to play with, and get confused
by

LSM= (I'll count apparmor.enabled= here as well)
security=
lsm.enabled=
lsm.disabled=

I really don't like this, it will be very confusing for users. I also
think an authoritative list of what is enabled is easier for users
than mixing a list of whats enabled with kernel config default
settings.

Under the current scheme

lsm.enabled=selinux

could actually mean selinux,yama,loadpin,something_else are
enabled. If we extend this behavior to when full stacking lands

lsm.enabled=selinux,yama

might mean selinux,yama,apparmor,loadpin,something_else

and what that list is will vary from kernel to kernel, which I think
is harder for the user than the lsm.enabled list being what is
actually enabled at boot

If we have to have multiple kernel parameter, I prefer a behvior where
if you hav conflicting kernel parameters specified

  apparmor=0 lsm.enabled=apparmor

that the conflict is logged and the lsm is left disabled, as I think
it is easier for users to understand than the overrides scheme of v3,
and sans logging of the conflict is effectively what we had in the
past

  apparmor=0 security=apparmor
or
  apparmor=1 security=selinux

would result in apparmor being disabed


That being said I get we have a mess currently, and there really
doesn't seem to be a good way to fix it. I think getting this right
for the user is important enough that I am willing to break current
apparmor userspace api. While apparmor=0 is documented we have also
documented security=X for years and apparmor=0 isn't used too often
so I think we can drop it to help clean this mess up abit.

I am not going to Nak, or block on v3 behavior if that is considered
the best path forward after this discussion/rant.


> v4 removed the per-LSM boot params and CONFIGs at John's request, but
> Paul and Stephen don't want this for SELinux.
> 
> The pieces for reducing conflict with CONFIG_LSM_ENABLE and
> lsm.{enable,disable}= were:
> 
> 1- Remove SECURITY_APPARMOR_BOOTPARAM_VALUE.
> 2- Remove apparmor= and apparmor.enabled=.
> 3- Remove SECURITY_SELINUX_BOOTPARAM_VALUE.
> 4- Remove selinux=.
> 
> v4 used all of 1-4 above. SELinux says "4" cannot happen as it's too
> commonly used. Would 3 be okay for SELinux?
> 
> John, with 4 not happening, do you prefer to not have 2 happen?
> 
> With CONFIGs removed, then the boot time defaults are controlled by
> CONFIG_LSM_ENABLE, but the boot params continue to work as before.
> Only the use of the new lsm.enable= and lsm.disable= would override
> the per-LSM boot params. This would clean up the build-time CONFIG
> weirdness, and leave the existing boot params as before (putting us
> functionally in between the v3 and v4 series).
> 
I'm ambivalent. I really want to clean this up but atm it doesn't
really look like 2 is going to provide much of a benefit. If you
think it helps clean this up, do it. Regardless 1 is going to
happen, and I will start updating documentation and try to get
users moving away from using the apparmor= kernel parameter.
