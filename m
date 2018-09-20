Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:45168 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbeIUFZP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 01:25:15 -0400
Subject: Re: [PATCH security-next v2 01/26] LSM: Correctly announce start of
 LSM initialization
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-2-keescook@chromium.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d273e21a-4323-f2ed-84ef-6b47e89633e4@schaufler-ca.com>
Date: Thu, 20 Sep 2018 16:39:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180920162338.21060-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920233912.JS0iHqhkyHnkBbC8O6obG9fHdeRe9TAIi7sKST-oVio@z>

On 9/20/2018 9:23 AM, Kees Cook wrote:
> For a while now, the LSM core has said it was "initializED", rather than
> "initializING". This adjust the report to be more accurate (i.e. before
> this was reported before any LSMs had been initialized.)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

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
