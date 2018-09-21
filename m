Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:36250 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727643AbeIUFuO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 01:50:14 -0400
Subject: Re: [PATCH security-next v2 18/26] LSM: Build ordered list of ordered
 LSMs for init
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-19-keescook@chromium.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d12fc06e-ff16-63c9-34ba-7303205b0a1d@schaufler-ca.com>
Date: Thu, 20 Sep 2018 17:04:03 -0700
MIME-Version: 1.0
In-Reply-To: <20180920162338.21060-19-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180921000403.7wpUlLRHS4P9TCMBLuhzHQO0mCf_f8r_1zJu9OzAi8Y@z>

On 9/20/2018 9:23 AM, Kees Cook wrote:
> This constructs a list of ordered LSMs to initialize, using a hard-coded
> list of only "integrity": minor LSMs continue to have direct hook calls,
> and major LSMs continue to initialize separately.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Do you think that this mechanism will be sufficiently
flexible to accommodate dynamically loaded security modules
in the future? While I am not personally an advocate of
dynamically loaded security modules I have been working to
ensure that I haven't done anything that would actively
interfere with someone who did.

> ---
>  security/security.c | 59 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 52 insertions(+), 7 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 25a019cc4a2b..2541a512a0f7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -34,6 +34,9 @@
>  
>  #define MAX_LSM_EVM_XATTR	2
>  
> +/* How many LSMs were built into the kernel? */
> +#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> +
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>  
> @@ -41,6 +44,9 @@ char *lsm_names;
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_major_lsm;
>  
> +/* Ordered list of LSMs to initialize. */
> +static __initdata struct lsm_info **ordered_lsms;
> +
>  static bool debug __initdata;
>  #define init_debug(...)						\
>  	do {							\
> @@ -74,6 +80,45 @@ static void __init set_enabled(struct lsm_info *lsm, bool enabled)
>  	}
>  }
>  
> +/* Is an LSM already listed in the ordered LSMs list? */
> +static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> +{
> +	struct lsm_info **check;
> +
> +	for (check = ordered_lsms; *check; check++)
> +		if (*check == lsm)
> +			return true;
> +
> +	return false;
> +}
> +
> +/* Append an LSM to the list of ordered LSMs to initialize. */
> +static int last_lsm __initdata;
> +static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
> +{
> +	/* Ignore duplicate selections. */
> +	if (exists_ordered_lsm(lsm))
> +		return;
> +
> +	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
> +		return;
> +
> +	ordered_lsms[last_lsm++] = lsm;
> +	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
> +		   (!lsm->enabled || *lsm->enabled) ? "en" : "dis");
> +}
> +
> +/* Populate ordered LSMs list from hard-coded list of LSMs. */
> +static void __init prepare_lsm_order(void)
> +{
> +	struct lsm_info *lsm;
> +
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (strcmp(lsm->name, "integrity") == 0)
> +			append_ordered_lsm(lsm, "builtin");
> +	}
> +}
> +
>  /* Is an LSM allowed to be enabled? */
>  static bool __init lsm_allowed(struct lsm_info *lsm)
>  {
> @@ -104,14 +149,10 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
>  
>  static void __init ordered_lsm_init(void)
>  {
> -	struct lsm_info *lsm;
> -
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
> -			continue;
> +	struct lsm_info **lsm;
>  
> -		maybe_initialize_lsm(lsm);
> -	}
> +	for (lsm = ordered_lsms; *lsm; lsm++)
> +		maybe_initialize_lsm(*lsm);
>  }
>  
>  static void __init major_lsm_init(void)
> @@ -141,6 +182,8 @@ int __init security_init(void)
>  	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
>  	     i++)
>  		INIT_HLIST_HEAD(&list[i]);
> +	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
> +				GFP_KERNEL);
>  
>  	/* Process "security=", if given. */
>  	if (!chosen_major_lsm)
> @@ -169,6 +212,7 @@ int __init security_init(void)
>  	loadpin_add_hooks();
>  
>  	/* Load LSMs in specified order. */
> +	prepare_lsm_order();
>  	ordered_lsm_init();
>  
>  	/*
> @@ -176,6 +220,7 @@ int __init security_init(void)
>  	 */
>  	major_lsm_init();
>  
> +	kfree(ordered_lsms);
>  	return 0;
>  }
>  
