From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v4 04/29] nios2: Exception handling
Date: Wed, 8 Oct 2014 23:27:22 +0100
Message-ID: <20141008222722.GJ7996@ZenIV.linux.org.uk>
References: <1412760595-3935-1-git-send-email-lftan@altera.com>
 <1412760595-3935-5-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49282 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbaJHW11 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Oct 2014 18:27:27 -0400
Content-Disposition: inline
In-Reply-To: <1412760595-3935-5-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, lftan.linux@gmail.com, cltang@codesourcery.com


> +Lsignal_return:
> +	ANDI32	r1, r10, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME
> +	beq	r1, r0, restore_all
> +	mov	r4, sp			/* pt_regs */
> +	SAVE_SWITCH_STACK
> +	call	do_notify_resume
> +	beq	r2, r0, no_work_pending
> +	RESTORE_SWITCH_STACK
> +	/* prepare restart syscall here without leaving kernel */
> +	ldw	r2, PT_R2(sp)	/* reload syscall number in r2 */
> +	ldw 	r4, PT_R4(sp)	/* reload syscall arguments r4-r9 */
> +	ldw 	r5, PT_R5(sp)
> +	ldw 	r6, PT_R6(sp)
> +	ldw 	r7, PT_R7(sp)
> +	ldw 	r8, PT_R8(sp)
> +	ldw 	r9, PT_R9(sp)
> +	br	local_restart	/* restart syscall */
> +
> +no_work_pending:
> +	RESTORE_SWITCH_STACK
> +	br	restore_all

Umm...  Branch to no_work_pending will be usuall taken.  How well does
branch predictor on that processor cope with such things?

Another thing is the point Richard made - multiple pending signals need to be
handled.  IOW, that should be a branch to ret_from_exception, not restore_all.
