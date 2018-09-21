Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:46752 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbeIUF6o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 01:58:44 -0400
Subject: Re: [PATCH security-next v2 20/26] LSM: Introduce "lsm.order=" for
 boottime ordering
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-21-keescook@chromium.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <71f833b8-40cb-83f8-6803-7df26e8fa460@schaufler-ca.com>
Date: Thu, 20 Sep 2018 17:12:30 -0700
MIME-Version: 1.0
In-Reply-To: <20180920162338.21060-21-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180921001230.3uFFc0uDFWMKisY-gUieMQI9_CIjXbSPt4bfyUAl2d0@z>

On 9/20/2018 9:23 AM, Kees Cook wrote:
> Provide a way to reorder LSM initialization using the new "lsm.order="
> comma-separated list of LSMs. Any LSMs not listed will be added in builtin
> order.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  security/security.c                             | 15 ++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 32d323ee9218..5ac4c1056ffa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2276,6 +2276,11 @@
>  
>  	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
>  
> +	lsm.order=lsm1,...,lsmN
> +			[SECURITY] Choose order of LSM initialization. Any
> +			builtin LSMs not listed here will be implicitly
> +			added to the list in builtin order.

Added at the end of the list, or beginning of the list?

> +
>  	machvec=	[IA-64] Force the use of a particular machine-vector
>  			(machvec) in a generic kernel.
>  			Example: machvec=hpzx1_swiotlb
> diff --git a/security/security.c b/security/security.c
> index 063ee2466e58..4db194f81419 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -43,6 +43,7 @@ static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>  char *lsm_names;
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_major_lsm;
> +static __initdata const char *chosen_lsm_order;
>  
>  static __initconst const char * const builtin_lsm_order = CONFIG_LSM_ORDER;
>  
> @@ -136,11 +137,15 @@ static void __init parse_lsm_order(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> -/* Populate ordered LSMs list from builtin list of LSMs. */
> +/* Populate ordered LSMs list from commandline and builtin list of LSMs. */
>  static void __init prepare_lsm_order(void)
>  {
>  	struct lsm_info *lsm;
>  
> +	/* Parse order from commandline, if present. */
> +	if (chosen_lsm_order)
> +		parse_lsm_order(chosen_lsm_order, "cmdline");
> +
>  	/* Parse order from builtin list. */
>  	parse_lsm_order(builtin_lsm_order, "builtin");
>  
> @@ -264,6 +269,14 @@ static int __init choose_major_lsm(char *str)
>  }
>  __setup("security=", choose_major_lsm);
>  
> +/* Explicitly choose LSM initialization order. */
> +static int __init choose_lsm_order(char *str)
> +{
> +	chosen_lsm_order = str;
> +	return 1;
> +}
> +__setup("lsm.order=", choose_lsm_order);
> +
>  /* Enable LSM order debugging. */
>  static int __init enable_debug(char *str)
>  {
