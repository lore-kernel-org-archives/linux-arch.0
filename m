From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 09/29] LSM: Provide init debugging
 infrastructure
Date: Mon, 1 Oct 2018 14:14:19 -0700
Message-ID: <db53ecb3-e3b9-54f6-2873-d28ccfe6d6fe@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-10-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-10-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> Booting with "lsm.debug" will report future details on how LSM ordering
> decisions are being made.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>  .../admin-guide/kernel-parameters.txt          |  2 ++
>  security/security.c                            | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9871e649ffef..32d323ee9218 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2274,6 +2274,8 @@
>  	ltpc=		[NET]
>  			Format: <io>,<irq>,<dma>
>  
> +	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
> +
>  	machvec=	[IA-64] Force the use of a particular machine-vector
>  			(machvec) in a generic kernel.
>  			Example: machvec=hpzx1_swiotlb
> diff --git a/security/security.c b/security/security.c
> index e74f46fba591..ee49b921d750 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -12,6 +12,8 @@
>   *	(at your option) any later version.
>   */
>  
> +#define pr_fmt(fmt) "LSM: " fmt
> +
>  #include <linux/bpf.h>
>  #include <linux/capability.h>
>  #include <linux/dcache.h>
> @@ -43,11 +45,19 @@ char *lsm_names;
>  static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
>  	CONFIG_DEFAULT_SECURITY;
>  
> +static bool debug __initdata;
> +#define init_debug(...)						\
> +	do {							\
> +		if (debug)					\
> +			pr_info(__VA_ARGS__);			\
> +	} while (0)
> +
>  static void __init major_lsm_init(void)
>  {
>  	struct lsm_info *lsm;
>  
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		init_debug("initializing %s\n", lsm->name);
>  		lsm->init();
>  	}
>  }
> @@ -91,6 +101,14 @@ static int __init choose_lsm(char *str)
>  }
>  __setup("security=", choose_lsm);
>  
> +/* Enable LSM order debugging. */
> +static int __init enable_debug(char *str)
> +{
> +	debug = true;
> +	return 1;
> +}
> +__setup("lsm.debug", enable_debug);
> +
>  static bool match_last_lsm(const char *list, const char *lsm)
>  {
>  	const char *last;
> 
