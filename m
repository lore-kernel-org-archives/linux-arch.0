Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51168 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeJBDym (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Oct 2018 23:54:42 -0400
Subject: Re: [PATCH security-next v3 10/29] LSM: Don't ignore initialization
 failures
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-11-keescook@chromium.org>
From: John Johansen <john.johansen@canonical.com>
Message-ID: <9f1ca560-28bc-a95b-cc3b-f886e90fbbf9@canonical.com>
Date: Mon, 1 Oct 2018 14:14:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180925001832.18322-11-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181001211453.8XCbipvtTvOxspcDAjNwYmu-SrKRbX96jaG-SOOjh-g@z>

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
