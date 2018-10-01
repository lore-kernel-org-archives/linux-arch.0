From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 17/29] LSM: Introduce CONFIG_LSM_ENABLE
Date: Mon, 1 Oct 2018 14:34:52 -0700
Message-ID: <98805d7b-fa52-b4bb-bb66-3008b3d4d23f@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-18-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-18-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> To provide a set of default-enabled LSMs at boot, this introduces the
> new CONFIG_LSM_ENABLE. A value of "all" means all builtin LSMs are
> enabled by default. Any unlisted LSMs will be implicitly disabled
> (excepting those with LSM-specific CONFIGs for enabling/disabling).
> 
> The behavior of the LSM-specific CONFIGs for SELinux are AppArmor
> unchanged: the default-enabled state for those LSMs remains controlled
> through their LSM-specific "enable" CONFIGs.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

The patch is fine but I am not sure I like the behavior. I much prefer
that its an explicit list and nothing is left to implicit. That is
if there is a conflict between the list and the LSM-specific config
the LSM is disabled.



> ---
>  include/linux/lsm_hooks.h | 2 +-
>  security/Kconfig          | 8 ++++++++
>  security/security.c       | 4 +++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 95798f212dbf..ab23f1bc6d77 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>  struct lsm_info {
>  	const char *name;	/* Populated automatically. */
>  	unsigned long flags;	/* Optional: flags describing LSM */
> -	int *enabled;		/* Optional: NULL means enabled. */
> +	int *enabled;		/* Optional: NULL checks CONFIG_LSM_ENABLE */
>  	int (*init)(void);
>  };
>  
> diff --git a/security/Kconfig b/security/Kconfig
> index 27d8b2688f75..71306b046270 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -276,5 +276,13 @@ config DEFAULT_SECURITY
>  	default "apparmor" if DEFAULT_SECURITY_APPARMOR
>  	default "" if DEFAULT_SECURITY_DAC
>  
> +config LSM_ENABLE
> +	string "LSMs to enable at boot time"
> +	default "all"
> +	help
> +	  A comma-separate list of LSMs to enable by default at boot. The
> +	  default is "all", to enable all LSM modules at boot. Any LSMs
> +	  not listed here will be disabled by default.
> +
>  endmenu
>  
> diff --git a/security/security.c b/security/security.c
> index a8107d54b3d3..7ecb9879a863 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -45,6 +45,8 @@ char *lsm_names;
>  static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
>  	CONFIG_DEFAULT_SECURITY;
>  
> +static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
> +
>  static bool debug __initdata;
>  #define init_debug(...)						\
>  	do {							\
> @@ -182,7 +184,7 @@ static void __init parse_lsm_enable(const char *str,
>  static void __init prepare_lsm_enable(void)
>  {
>  	/* Prepare defaults. */
> -	parse_lsm_enable("all", default_enabled, true);
> +	parse_lsm_enable(builtin_lsm_enable, default_enabled, true);
>  }
>  
>  /**
> 
