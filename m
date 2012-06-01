From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 05/20] hexagon: Do not call do_signal() with irqs
 disabled
Date: Fri, 1 Jun 2012 14:02:01 -0500
Message-ID: <20120601190201.GD23541@codeaurora.org>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
 <1337983476-22081-5-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:30782 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965720Ab2FATCD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 15:02:03 -0400
Content-Disposition: inline
In-Reply-To: <1337983476-22081-5-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org

On Sat, May 26, 2012 at 12:04:21AM +0200, Richard Weinberger wrote:
> get_signal_to_deliver() calls try_to_freeze() which might sleep.
> 
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/hexagon/kernel/signal.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/hexagon/kernel/signal.c b/arch/hexagon/kernel/signal.c
> index 434866e..8403bfd 100644
> --- a/arch/hexagon/kernel/signal.c
> +++ b/arch/hexagon/kernel/signal.c
> @@ -22,6 +22,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
>  #include <linux/tracehook.h>
> +#include <linux/irqflags.h>
>  #include <asm/registers.h>
>  #include <asm/thread_info.h>
>  #include <asm/unistd.h>
> @@ -267,6 +268,8 @@ no_restart:
>  
>  void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
>  {
> +	local_irq_enable();
> +
>  	if (thread_info_flags & _TIF_SIGPENDING)
>  		do_signal(regs);
>  
> -- 
> 1.7.7.3
> 

Acked-by:  Richard Kuo <rkuo@codeaurora.org>


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
