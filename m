From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 01/29] LSM: Correctly announce start of
 LSM initialization
Date: Mon, 1 Oct 2018 14:05:32 -0700
Message-ID: <9c0f5719-1028-bb8b-972e-dd38f4358f84@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-2-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-2-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> For a while now, the LSM core has said it was "initializED", rather than
> "initializING". This adjust the report to be more accurate (i.e. before
> this was reported before any LSMs had been initialized.)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  security/security.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 736e78da1ab9..4cbcf244a965 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -72,10 +72,11 @@ int __init security_init(void)
>  	int i;
>  	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
>  
> +	pr_info("Security Framework initializing\n");
> +
>  	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
>  	     i++)
>  		INIT_HLIST_HEAD(&list[i]);
> -	pr_info("Security Framework initialized\n");
>  
>  	/*
>  	 * Load minor LSMs, with the capability module always first.
> 
