From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [RFC PATCH] arm64: signal: Make parse_user_sigframe()
 independent of rt_sigframe layout
Date: Sun, 25 Jun 2017 18:05:44 +0300
Message-ID: <20170625150544.2qsh4hpnmxygmcft@yury-thinkpad>
References: <1498208859-6099-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0069.outbound.protection.outlook.com ([104.47.38.69]:16615
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751008AbdFYPGA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 25 Jun 2017 11:06:00 -0400
Content-Disposition: inline
In-Reply-To: <1498208859-6099-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

On Fri, Jun 23, 2017 at 10:07:39AM +0100, Dave Martin wrote:
> ILP32 support uses the same struct sigcontext as the native ABI
> (i.e., LP64), but a different layout for the rest of the signal
> frame (since siginfo_t and ucontext_t are both ABI-dependent).
> 
> Since the purpose of parse_user_sigframe() is really to parse
> sigcontext and not the whole signal frame, the function does not
> need to depend on the layout of rt_sigframe -- the only purpose of
> the rt_sigframe pointer is for use as a base to measure the signal
> frame size.
> 
> So, this patch renames the function to parse_user_sigcontext() and
> makes the sigframe base pointer generic.  ABI-specific parsers that
> share the same sigcontext definition can then call it.
> 
> To minimise churn in this patch, the native LP64 parser is retained
> under the old name, but becomes a call to parse_user_sigconext().
> It may make sense instead to fold this into its restore_sigframe(),
> depending on how ILP32 support is integrated.
> 
> Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
> 
> This patch depends on [1], which does not appear to be applied yet.
> 
> [1] [PATCH] arm64: signal: Allow expansion of the signal frame                  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/514699.html
> 
>  arch/arm64/kernel/signal.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index e47cd3a..a189321 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -223,16 +223,16 @@ struct user_ctxs {
>  	struct fpsimd_context __user *fpsimd;
>  };
>  
> -static int parse_user_sigframe(struct user_ctxs *user,
> -			       struct rt_sigframe __user *sf)
> +static int parse_user_sigcontext(struct user_ctxs *user,
> +				 struct sigcontext __user const *sc,
> +				 void __user const *sigframe_base)
>  {
> -	struct sigcontext __user *const sc = &sf->uc.uc_mcontext;
>  	struct _aarch64_ctx __user *head;
>  	char __user *base = (char __user *)&sc->__reserved;
>  	size_t offset = 0;
>  	size_t limit = sizeof(sc->__reserved);
>  	bool have_extra_context = false;
> -	char const __user *const sfp = (char const __user *)sf;
> +	char const __user *const sfp = (char const __user *)sigframe_base;
>  
>  	user->fpsimd = NULL;
>  
> @@ -366,6 +366,12 @@ static int parse_user_sigframe(struct user_ctxs *user,
>  	return -EINVAL;
>  }
>  
> +static int parse_user_sigframe(struct user_ctxs *user,
> +			       struct rt_sigframe __user const *sf)
> +{
> +	return parse_user_sigcontext(user, &sf->uc.uc_mcontext, sf);
> +}
> +

Hi Dave, 

Thank you. Seems this is what I need. Only one thing. We can #define
parse_user_sigframe() as macro, and so bypass type control.
The macro then will be used both by lp64 and ilp32 without any
modification.

Yury

>  static int restore_sigframe(struct pt_regs *regs,
>  			    struct rt_sigframe __user *sf)
>  {
> -- 
> 2.1.4
