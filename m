From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 10/29] LSM: Don't ignore initialization
 failures
Date: Mon, 1 Oct 2018 14:14:53 -0700
Message-ID: <9f1ca560-28bc-a95b-cc3b-f886e90fbbf9@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-11-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-11-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> LSM initialization failures have traditionally been ignored. We should
> at least WARN when something goes wrong.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

about time

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  security/security.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index ee49b921d750..1f055936a746 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -55,10 +55,12 @@ static bool debug __initdata;
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
