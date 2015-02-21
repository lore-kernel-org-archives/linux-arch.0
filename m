From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v4 05/15] h8300: Process and signal
Date: Sat, 21 Feb 2015 09:51:23 +0000
Message-ID: <20150221095123.GV29656@ZenIV.linux.org.uk>
References: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
 <1424505239-7082-6-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34820 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbbBUJv0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Feb 2015 04:51:26 -0500
Content-Disposition: inline
In-Reply-To: <1424505239-7082-6-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, Feb 21, 2015 at 04:53:49PM +0900, Yoshinori Sato wrote:

> +static inline void *
> +get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
> +{
> +	unsigned long usp;
> +
> +	/* Default to using normal stack.  */
> +	usp = rdusp();
> +
> +	/* This is the X/Open sanctioned signal stack switching.  */
> +	if (ka->sa.sa_flags & SA_ONSTACK) {
> +		if (!sas_ss_flags(usp))
> +			usp = current->sas_ss_sp + current->sas_ss_size;
> +	}

Use sigsp(), please.  Pass ksig to that sucker and it'll become
	return (void *)((sigsp(rdusp, ksig) - frame_size) & -8UL);

> +static void do_signal(struct pt_regs *regs)
> +	 * We want the common case to go fast, which
> +	 * is why we may in certain cases get here from
> +	 * kernel mode. Just return without doing anything
> +	 * if so.
> +	 */
> +	if ((regs->ccr & 0x10))
> +		return;

Can we get there in kernel mode, actually?
