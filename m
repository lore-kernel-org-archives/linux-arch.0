From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 19/29] LSM: Prepare for reorganizing
 "security=" logic
Date: Mon, 1 Oct 2018 14:47:37 -0700
Message-ID: <0a668ede-bf8a-33eb-13cc-a1667c974944@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-20-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-20-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> This moves the string handling for "security=" boot parameter into
> a stored pointer instead of a string duplicate. This will allow
> easier handling of the string when switching logic to use the coming
> enable/disable infrastructure.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>  security/security.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 456a3f73bc36..e325fcc41f00 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -34,18 +34,14 @@
>  
>  #define MAX_LSM_EVM_XATTR	2
>  
> -/* Maximum number of letters for an LSM name string */
> -#define SECURITY_NAME_MAX	10
> -
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>  
>  char *lsm_names;
>  /* Boot-time LSM user choice */
> -static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
> -	CONFIG_DEFAULT_SECURITY;
>  static __initdata const char *chosen_lsm_enable;
>  static __initdata const char *chosen_lsm_disable;
> +static __initdata const char *chosen_major_lsm;
>  
>  static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
>  
> @@ -112,7 +108,7 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
>  		return true;
>  
>  	/* Disabled if this LSM isn't the chosen one. */
> -	if (strcmp(lsm->name, chosen_lsm) != 0)
> +	if (strcmp(lsm->name, chosen_major_lsm) != 0)
>  		return false;
>  
>  	return true;
> @@ -191,6 +187,9 @@ static void __init prepare_lsm_enable(void)
>  	/* Process "lsm.enable=" and "lsm.disable=", if given. */
>  	parse_lsm_enable(chosen_lsm_enable, set_enabled, true);
>  	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
> +
> +	if (!chosen_major_lsm)
> +		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
>  }
>  
>  /**
> @@ -231,12 +230,12 @@ int __init security_init(void)
>  }
>  
>  /* Save user chosen LSM */
> -static int __init choose_lsm(char *str)
> +static int __init choose_major_lsm(char *str)
>  {
> -	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
> +	chosen_major_lsm = str;
>  	return 1;
>  }
> -__setup("security=", choose_lsm);
> +__setup("security=", choose_major_lsm);
>  
>  /* Enable LSM order debugging. */
>  static int __init enable_debug(char *str)
> 
