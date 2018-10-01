From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and
 lsm.disable=
Date: Mon, 1 Oct 2018 15:48:14 -0700
Message-ID: <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com>
 <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 10/01/2018 03:27 PM, Kees Cook wrote:
> On Mon, Oct 1, 2018 at 2:46 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/24/2018 05:18 PM, Kees Cook wrote:
>>> This introduces the "lsm.enable=..." and "lsm.disable=..." boot parameters
>>> which each can contain a comma-separated list of LSMs to enable or
>>> disable, respectively. The string "all" matches all LSMs.
>>>
>>> This has very similar functionality to the existing per-LSM enable
>>> handling ("apparmor.enabled=...", etc), but provides a centralized
>>> place to perform the changes. These parameters take precedent over any
>>> LSM-specific boot parameters.
>>>
>>> Disabling an LSM means it will not be considered when performing
>>> initializations. Enabling an LSM means either undoing a previous
>>> LSM-specific boot parameter disabling or a undoing a default-disabled
>>> CONFIG setting.
>>>
>>> For example: "lsm.disable=apparmor apparmor.enabled=1" will result in
>>> AppArmor being disabled. "selinux.enabled=0 lsm.enable=selinux" will
>>> result in SELinux being enabled.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> I don't like this. It brings about conflicting kernel params that are
>> bound to confuse users. Its pretty easy for a user to understand that
>> when they specify a parameter manually at boot, that  it overrides the
>> build time default. But conflicting kernel parameters are a lot harder
>> to deal with.
>>
>> I prefer a plain enabled= list being an override of the default build
>> time value. Where conflicts with LSM-specific configs always result in
>> the LSM being disabled with a complaint about the conflict.
>>
>> Though I have yet to be convinced its worth the cost, I do recognize
>> it is sometimes convenient to disable a single LSM, instead of typing
>> in a whole list of what to enable. If we have to have conflicting
>> kernel parameters I would prefer that the conflict throw up a warning
>> and leaving the LSM with the conflicting config disabled.
> 
> Alright, let's drill down a bit more. I thought I had all the
> requirements sorted out here. :)
> 
> AppArmor and SELinux are "special" here in that they have both:
> 
> - CONFIG for enable-ness
> - boot param for enable-ness
> 
> Now, the way this worked in the past was that combined with
> CONFIG_DEFAULT_SECURITY and the link-time ordering, this resulted in a
> way to get the LSM enabled, skipped, etc. But it was highly CONFIG
> dependent.
> 
> SELinux does:
> 
> #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
> int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
> 
> static int __init selinux_enabled_setup(char *str)
> {
>         unsigned long enabled;
>         if (!kstrtoul(str, 0, &enabled))
>                 selinux_enabled = enabled ? 1 : 0;
>         return 1;
> }
> __setup("selinux=", selinux_enabled_setup);
> #else
> int selinux_enabled = 1;
> #endif
> ...
>         if (!security_module_enable("selinux")) {
>                 selinux_enabled = 0;
>                 return 0;
>         }
> 
>         if (!selinux_enabled) {
>                 pr_info("SELinux:  Disabled at boot.\n");
>                 return 0;
>         }
> 
> 
> AppArmor does:
> 
> /* Boot time disable flag */
> static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
> module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
> 
> static int __init apparmor_enabled_setup(char *str)
> {
>         unsigned long enabled;
>         int error = kstrtoul(str, 0, &enabled);
>         if (!error)
>                 apparmor_enabled = enabled ? 1 : 0;
>         return 1;
> }
> 
> __setup("apparmor=", apparmor_enabled_setup);
> ...
>         if (!apparmor_enabled || !security_module_enable("apparmor")) {
>                 aa_info_message("AppArmor disabled by boot time parameter");
>                 apparmor_enabled = false;
>                 return 0;
>         }
> 
> 
> Smack and TOMOYO each do:
> 
>         if (!security_module_enable("smack"))
>                 return 0;
> 
>         if (!security_module_enable("tomoyo"))
>                 return 0;
> 
> 
> Capability, Integrity, Yama, and LoadPin always run init. (This series
> fixes LoadPin to separate enable vs enforce, so we can ignore its
> "enable" setting, which isn't an "am I active?" boolean -- its init
> was always run.) With the enable logic is lifted out of the LSMs, we
> want to have "implicit enable" for 6 of 8 of the LSMs. (Which is why I
> had originally suggested CONFIG_LSM_DISABLE, since the normal state is
> enabled.) But given your feedback, I made this "implicit disable" and
> added CONFIG_LSM_ENABLE instead. (For which "CONFIG_LSM_ENABLE=all"
> gets the same results.)
> 
> 
> I think, then, the first question (mainly for you and Paul) is:
> 
> Should we remove CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE and
> CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE in favor of only
> CONFIG_LSM_ENABLE?
> 

We can remove the Kconfig for the apparmor bootparam value. In fact I
will attach that patch below. I can't get rid of the parameter as it
is part of the userspace api. There are tools and applications
checking /sys/module/apparmor/parameters/enabled

but we can certainly default it to enabled and make it work only as a
runtime kernel parameter to disable apparmor which is how it has been
traditionally been used.

> The answer will affect the next question: what should be done with the
> boot parameters? AppArmor has two ways to change enablement:
> apparmor=0/1 and apparmor.enabled=0/1. SELinux just has selinux=0/1.
> Should those be removed in favor of "lsm.enable=..."? (And if they're
> not removed, how do people imagine they should interact?)
> 

I am not against removing the apparmor one, it does mean retraining
users but it is seldmon used so it may be worth dropping. If we keep
it, it should be a disable only flag that where the use of apparmor=0
or apparmor.enable=0 (same thing) means apparmor is disabled.

---

commit 367b8a47105c68fa170bdd14b0204555eb930476
Author: John Johansen <john.johansen@canonical.com>
Date:   Mon Oct 1 15:46:02 2018 -0700

    apparmor: remove apparmor boot param config
    
    The boot param value is only ever used as a means to disable apparmor.
    Get rid of the Kconfig and a default the parameter to true.
    
    Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index b6b68a7750ce..3de21f46c82a 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -14,22 +14,6 @@ config SECURITY_APPARMOR
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_APPARMOR_BOOTPARAM_VALUE
-	int "AppArmor boot parameter default value"
-	depends on SECURITY_APPARMOR
-	range 0 1
-	default 1
-	help
-	  This option sets the default value for the kernel parameter
-	  'apparmor', which allows AppArmor to be enabled or disabled
-          at boot.  If this option is set to 0 (zero), the AppArmor
-	  kernel parameter will default to 0, disabling AppArmor at
-	  boot.  If this option is set to 1 (one), the AppArmor
-	  kernel parameter will default to 1, enabling AppArmor at
-	  boot.
-
-	  If you are unsure how to answer this question, answer 1.
-
 config SECURITY_APPARMOR_HASH
 	bool "Enable introspection of sha1 hashes for loaded profiles"
 	depends on SECURITY_APPARMOR
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f09fea0b4db7..8e83ee52a0a3 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1303,7 +1303,7 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+static bool apparmor_enabled = true;
 module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
 
 static int __init apparmor_enabled_setup(char *str)
