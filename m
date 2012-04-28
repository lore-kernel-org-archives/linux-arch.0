From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC] TIF_NOTIFY_RESUME, arch/*/*/*signal*.c and all such
Date: Sat, 28 Apr 2012 04:36:06 +0100
Message-ID: <20120428033606.GU6871@ZenIV.linux.org.uk>
References: <20120426183742.GA324@redhat.com>
 <20120426231942.GJ6871@ZenIV.linux.org.uk>
 <20120427172444.GA30267@redhat.com>
 <20120427184528.GL6871@ZenIV.linux.org.uk>
 <20120427202002.8ED632C0BF@topped-with-meat.com>
 <20120427211244.GO6871@ZenIV.linux.org.uk>
 <20120427212729.652542C0AF@topped-with-meat.com>
 <20120427231526.GP6871@ZenIV.linux.org.uk>
 <20120428024208.GS6871@ZenIV.linux.org.uk>
 <20120428033245.GT6871@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:53529 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab2D1DgI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Apr 2012 23:36:08 -0400
Content-Disposition: inline
In-Reply-To: <20120428033245.GT6871@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Apr 28, 2012 at 04:32:45AM +0100, Al Viro wrote:
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 82aaf0a..e147619 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -57,6 +57,9 @@ work_pending:
>  	 * TIF_SIGPENDING or TIF_NOTIFY_RESUME must've been set if we got here
>  	 */
>  	mov	r0, sp				@ 'regs'
> +	ldr	r2, [sp, #S_PSR]
> +	tst	r2, #15
> +	be	no_work_pending

bne, actually.  Apologies for braino...
