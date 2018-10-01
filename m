From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 16/29] LSM: Prepare for arbitrary LSM
 enabling
Date: Mon, 1 Oct 2018 14:22:04 -0700
Message-ID: <b16a8882-4e88-0340-84b4-0fd2f8797206@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-17-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-17-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> Before now, all the LSMs that did not specify an "enable" variable in their
> struct lsm_info were considered enabled by default. This prepares to make
> LSM enabling more explicit. For all LSMs without an explicit "enable"
> variable, a hard-coded storage location is chosen, and all LSMs without
> an external "enable" state have their state explicitly set to "enabled".
> 
> This code appears more complex than it needs to be (comma-separated
> list parsing and "set" function parameter) because its use will be
> expanded on in the following patches to provide more explicit enabling.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>  security/security.c | 69 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 056b36cf6245..a8107d54b3d3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -54,17 +54,46 @@ static bool debug __initdata;
>  
>  static bool __init is_enabled(struct lsm_info *lsm)
>  {
> -	if (!lsm->enabled || *lsm->enabled)
> -		return true;
> +	if (WARN_ON(!lsm->enabled))
> +		return false;
>  
> -	return false;
> +	return *lsm->enabled;
>  }
>  
>  /* Mark an LSM's enabled flag, if it exists. */
> -static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +static int lsm_enabled_true __initdata = 1;
> +static int lsm_enabled_false __initdata = 0;
> +
> +static void __init default_enabled(struct lsm_info *lsm, bool enabled)
>  {
> +	/* If storage location already set, skip this one. */
>  	if (lsm->enabled)
> +		return;
> +
> +	/*
> +	 * When an LSM hasn't configured an enable variable, we can use
> +	 * a hard-coded location for storing the default enabled state.
> +	 */
> +	if (enabled)
> +		lsm->enabled = &lsm_enabled_true;
> +	else
> +		lsm->enabled = &lsm_enabled_false;
> +}
> +
> +static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +{
> +	if (WARN_ON(!lsm->enabled))
> +		return;
> +
> +	if (lsm->enabled == &lsm_enabled_true) {
> +		if (!enabled)
> +			lsm->enabled = &lsm_enabled_false;
> +	} else if (lsm->enabled == &lsm_enabled_false) {
> +		if (enabled)
> +			lsm->enabled = &lsm_enabled_true;
> +	} else {
>  		*lsm->enabled = enabled;
> +	}
>  }
>  
>  /* Is an LSM allowed to be initialized? */
> @@ -127,6 +156,35 @@ static void __init major_lsm_init(void)
>  	}
>  }
>  
> +static void __init parse_lsm_enable(const char *str,
> +				    void (*set)(struct lsm_info *, bool),
> +				    bool enabled)
> +{
> +	char *sep, *name, *next;
> +
> +	if (!str)
> +		return;
> +
> +	sep = kstrdup(str, GFP_KERNEL);
> +	next = sep;
> +	while ((name = strsep(&next, ",")) != NULL) {
> +		struct lsm_info *lsm;
> +
> +		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +			if (strcmp(name, "all") == 0 ||
> +			    strcmp(name, lsm->name) == 0)
> +				set(lsm, enabled);
> +		}
> +	}
> +	kfree(sep);
> +}
> +
> +static void __init prepare_lsm_enable(void)
> +{
> +	/* Prepare defaults. */
> +	parse_lsm_enable("all", default_enabled, true);
> +}
> +
>  /**
>   * security_init - initializes the security framework
>   *
> @@ -143,6 +201,9 @@ int __init security_init(void)
>  	     i++)
>  		INIT_HLIST_HEAD(&list[i]);
>  
> +	/* Figure out which LSMs are enabled and disabled. */
> +	prepare_lsm_enable();
> +
>  	/*
>  	 * Load minor LSMs, with the capability module always first.
>  	 */
> 
