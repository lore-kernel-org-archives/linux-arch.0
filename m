Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51136 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeJBDxo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Oct 2018 23:53:44 -0400
Subject: Re: [PATCH security-next v3 08/29] LSM: Record LSM name in struct
 lsm_info
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-9-keescook@chromium.org>
From: John Johansen <john.johansen@canonical.com>
Message-ID: <a286ab41-b012-8a76-3e61-5a755525b20c@canonical.com>
Date: Mon, 1 Oct 2018 14:13:55 -0700
MIME-Version: 1.0
In-Reply-To: <20180925001832.18322-9-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: James Morris <james.morris@microsoft.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181001211355.9WI0jukFvvT4pIsqHXJg5GthZgvpyEWbm2i9d6vcsJk@z>

On 09/24/2018 05:18 PM, Kees Cook wrote:
> In preparation for making LSM selections outside of the LSMs, include
> the name of LSMs in struct lsm_info.
> 
> Cc: James Morris <james.morris@microsoft.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I'll leave this one until after the changes you have already discussed with Tetsuo around, END_LSM and .name

> ---
>  include/linux/lsm_hooks.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 02ec717189f9..543636f18152 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2040,16 +2040,20 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>  				char *lsm);
>  
>  struct lsm_info {
> +	const char *name;	/* Populated automatically. */
>  	int (*init)(void);
>  };
>  
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  
>  #define DEFINE_LSM(lsm)							\
> +	static const char __lsm_name_##lsm[] __initconst		\
> +		__aligned(1) = #lsm;					\
>  	static struct lsm_info __lsm_##lsm				\
>  		__used __section(.lsm_info.init)			\
>  		__aligned(sizeof(unsigned long))			\
>  		= {							\
> +			.name = __lsm_name_##lsm,			\
>  
>  #define END_LSM	  }
>  
> 
