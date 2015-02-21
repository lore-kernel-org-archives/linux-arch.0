From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v4 03/15] h8300: Exception and Interrupt handling
Date: Sat, 21 Feb 2015 09:58:04 +0000
Message-ID: <20150221095804.GW29656@ZenIV.linux.org.uk>
References: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
 <1424505239-7082-4-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34836 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbbBUJ6F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Feb 2015 04:58:05 -0500
Content-Disposition: inline
In-Reply-To: <1424505239-7082-4-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, Feb 21, 2015 at 04:53:47PM +0900, Yoshinori Sato wrote:

> +resume_userspace:
> +	andc	#0xbf,ccr
> +	mov.l	sp,er4
> +	and.w	#0xe000,r4		/* er4 <- current thread info */
> +	mov.l	@(TI_FLAGS:16,er4),er1
> +	and.l	#_TIF_WORK_MASK,er1
> +	beq	restore_all:8
> +work_pending:
> +	btst	#TIF_NEED_RESCHED,r1l
> +	bne	work_resched:8
> +	/* work notifysig */
> +	mov.l	sp,er0
> +	subs	#4,er0			/* er0: pt_regs */
> +	jsr	@do_notify_resume
> +	bra	restore_all:8

This is wrong.  You really need to handle multiple signals; it ought to
reload er1 and recheck it (or just branch to resume_userspace instead)
