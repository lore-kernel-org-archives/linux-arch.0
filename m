From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v4 10/32] LSM: Don't ignore initialization
 failures
Date: Wed, 3 Oct 2018 07:20:32 +1000 (AEST)
Message-ID: <alpine.LRH.2.21.1810030719040.23596@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-11-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-11-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 1 Oct 2018, Kees Cook wrote:

> LSM initialization failures have traditionally been ignored. We should
> at least WARN when something goes wrong.

I guess we could have a boot param which specifies what to do if any LSM 
fails to init, as I think some folks will want to stop execution at that 
point.

Thoughts?


> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  security/security.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 395f804f6a91..2055af907eba 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -55,10 +55,12 @@ static __initdata bool debug;
>  static void __init major_lsm_init(void)
>  {
>  	struct lsm_info *lsm;
> +	int ret;
>  
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  		init_debug("initializing %s\n", lsm->name);
> -		lsm->init();
> +		ret = lsm->init();
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
>  	}
>  }
>  
> 

-- 
James Morris
<jmorris@namei.org>
