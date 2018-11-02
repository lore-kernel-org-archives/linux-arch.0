From: Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH security-next v5 12/30] LSM: Provide separate ordered
 initialization
Date: Fri, 02 Nov 2018 14:13:26 -0400
Message-ID: <1541182406.20901.31.camel@linux.ibm.com>
References: <20181011001846.30964-1-keescook@chromium.org>
         <20181011001846.30964-13-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011001846.30964-13-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Kees,

On Wed, 2018-10-10 at 17:18 -0700, Kees Cook wrote:
> This provides a place for ordered LSMs to be initialized, separate from
> the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
> ordered_lsm_init(), but it will change drastically in later patches.
> 
> What is not obvious in the patch is that this change moves the integrity
> LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
> with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
> list, there is no reordering yet created.

I'm so sorry for not reviewing these patches earlier.  Both IMA and
EVM are dependent on "integrity", but "integrity", at least by itself,
should not be considered an LSM.

I don't recall why "integrity" is on the security_initcall, while both
IMA and EVM are on the late_initcall().

Mimi

> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  security/security.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index 2055af907eba..ebbbb672ced5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -52,12 +52,30 @@ static __initdata bool debug;
>  			pr_info(__VA_ARGS__);			\
>  	} while (0)
> 
> +static void __init ordered_lsm_init(void)
> +{
> +	struct lsm_info *lsm;
> +	int ret;
> +
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
> +			continue;
> +
> +		init_debug("initializing %s\n", lsm->name);
> +		ret = lsm->init();
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +	}
> +}
> +
>  static void __init major_lsm_init(void)
>  {
>  	struct lsm_info *lsm;
>  	int ret;
> 
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
> +			continue;
> +
>  		init_debug("initializing %s\n", lsm->name);
>  		ret = lsm->init();
>  		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> @@ -87,6 +105,9 @@ int __init security_init(void)
>  	yama_add_hooks();
>  	loadpin_add_hooks();
> 
> +	/* Load LSMs in specified order. */
> +	ordered_lsm_init();
> +
>  	/*
>  	 * Load all the remaining security modules.
>  	 */
