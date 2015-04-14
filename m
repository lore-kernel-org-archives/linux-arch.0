Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33366 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbbDNIlD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Apr 2015 04:41:03 -0400
Date: Tue, 14 Apr 2015 09:40:56 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: Removed unused variable
Message-ID: <20150414084056.GA26861@arm.com>
References: <1428951138-26046-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1428951138-26046-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20150414084056.YzFFpMkhTBaxSP9RRjX79DwStrqm2dqugAHtUDDJZyg@z>

On Mon, Apr 13, 2015 at 07:52:18PM +0100, Richard Weinberger wrote:
> arch/arm64/kernel/signal.c: In function ‘handle_signal’:
> arch/arm64/kernel/signal.c:290:22: warning: unused variable ‘thread’ [-Wunused-variable]
> 
> Fixes: arm64: Remove signal translation and exec_domain
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Will be applied on top of my execdomain removal series.

Sounds good, feel free to add my ack:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

> Thanks,
> //richard
> ---
>  arch/arm64/kernel/signal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 9f28eaa..e18c48c 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -287,7 +287,6 @@ static void setup_restart_syscall(struct pt_regs *regs)
>   */
>  static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  {
> -	struct thread_info *thread = current_thread_info();
>  	struct task_struct *tsk = current;
>  	sigset_t *oldset = sigmask_to_save();
>  	int usig = ksig->sig;
> -- 
> 1.8.4.5
> 
