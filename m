From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/6] generic sys_old_select
Date: Mon, 01 Feb 2010 23:40:29 +0100
Message-ID: <m24om0shpe.fsf@igel.home>
References: <20100201185506.GA11045@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56012 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab0BAWki (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Feb 2010 17:40:38 -0500
In-Reply-To: <20100201185506.GA11045@lst.de> (Christoph Hellwig's message of
	"Mon, 1 Feb 2010 19:55:06 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, dhowells@redhat.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

Christoph Hellwig <hch@lst.de> writes:

> Index: linux-2.6/fs/compat.c
> ===================================================================
> --- linux-2.6.orig/fs/compat.c	2010-01-12 14:08:16.202003005 +0100
> +++ linux-2.6/fs/compat.c	2010-01-29 23:35:20.187003404 +0100
> @@ -1795,6 +1795,24 @@ asmlinkage long compat_sys_select(int n,
>  	return ret;
>  }
>  
> +struct compat_sel_arg_struct {
> +	compat_ulong_t n;
> +	compat_ulong_t inp;
> +	compat_ulong_t outp;
> +	compat_ulong_t exp;
> +	compat_ulong_t tvp;
> +};

Shouldn't the last four be compat_uptr_t?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
