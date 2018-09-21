Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:36287 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbeIUGMB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 02:12:01 -0400
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-27-keescook@chromium.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
Date: Thu, 20 Sep 2018 17:25:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180920162338.21060-27-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180921002545.E40Zxvz7kzyszk68C1kh570qHe6VmmqYO2KxRJ4lYM0@z>

On 9/20/2018 9:23 AM, Kees Cook wrote:
> This removes CONFIG_DEFAULT_SECURITY in favor of the explicit build-time
> ordering offered by CONFIG_LSM_ORDER, and adds all the exclusive LSMs
> to the ordered LSM initialization.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/Kconfig    | 39 +--------------------------------------
>  security/security.c | 23 +----------------------
>  2 files changed, 2 insertions(+), 60 deletions(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 33c9ac3cb759..a2e365420919 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -239,46 +239,9 @@ source security/yama/Kconfig
>  
>  source security/integrity/Kconfig
>  
> -choice
> -	prompt "Default security module"
> -	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
> -	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
> -	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
> -	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
> -	default DEFAULT_SECURITY_DAC
> -
> -	help
> -	  Select the security module that will be used by default if the
> -	  kernel parameter security= is not specified.
> -
> -	config DEFAULT_SECURITY_SELINUX
> -		bool "SELinux" if SECURITY_SELINUX=y
> -
> -	config DEFAULT_SECURITY_SMACK
> -		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
> -
> -	config DEFAULT_SECURITY_TOMOYO
> -		bool "TOMOYO" if SECURITY_TOMOYO=y
> -
> -	config DEFAULT_SECURITY_APPARMOR
> -		bool "AppArmor" if SECURITY_APPARMOR=y
> -
> -	config DEFAULT_SECURITY_DAC
> -		bool "Unix Discretionary Access Controls"
> -
> -endchoice
> -
> -config DEFAULT_SECURITY
> -	string
> -	default "selinux" if DEFAULT_SECURITY_SELINUX
> -	default "smack" if DEFAULT_SECURITY_SMACK
> -	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
> -	default "apparmor" if DEFAULT_SECURITY_APPARMOR
> -	default "" if DEFAULT_SECURITY_DAC
> -
>  config LSM_ORDER
>  	string "Default initialization order of builtin LSMs"
> -	default "yama,loadpin,integrity"
> +	default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"

If I want to compile all the major modules into my kernel and use
AppArmor by default would I use

	default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"

or

	default "yama,loadpin,integrity,apparmor"

When we have "blob-sharing" how could I compile in tomoyo,
but exclude it without a boot line option?

When we have full stacking, how could I compile in selinux
but exclude it?

>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be link-order initialized
> diff --git a/security/security.c b/security/security.c
> index f076fdc6b451..628e62fda5fe 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -130,7 +130,6 @@ static void __init parse_lsm_order(const char *order, const char *origin)
>  
>  		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  			if (lsm->order == LSM_ORDER_MUTABLE &&
> -			    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
>  			    strcmp(lsm->name, name) == 0) {
>  				append_ordered_lsm(lsm, origin);
>  				found = true;
> @@ -163,8 +162,7 @@ static void __init prepare_lsm_order(void)
>  
>  	/* Add any missing LSMs, in link order. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if (lsm->order == LSM_ORDER_MUTABLE &&
> -		    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
> +		if (lsm->order == LSM_ORDER_MUTABLE)
>  			append_ordered_lsm(lsm, "link-time");
>  	}
>  
> @@ -222,18 +220,6 @@ static void __init ordered_lsm_init(void)
>  		maybe_initialize_lsm(*lsm);
>  }
>  
> -static void __init major_lsm_init(void)
> -{
> -	struct lsm_info *lsm;
> -
> -	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
> -			continue;
> -
> -		maybe_initialize_lsm(lsm);
> -	}
> -}
> -
>  /**
>   * security_init - initializes the security framework
>   *
> @@ -253,8 +239,6 @@ int __init security_init(void)
>  				GFP_KERNEL);
>  
>  	/* Process "security=", if given. */
> -	if (!chosen_major_lsm)
> -		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
>  	if (chosen_major_lsm) {
>  		struct lsm_info *lsm;
>  
> @@ -275,11 +259,6 @@ int __init security_init(void)
>  	prepare_lsm_order();
>  	ordered_lsm_init();
>  
> -	/*
> -	 * Load all the remaining security modules.
> -	 */
> -	major_lsm_init();
> -
>  	kfree(ordered_lsms);
>  	return 0;
>  }
