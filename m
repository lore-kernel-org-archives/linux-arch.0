From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 1/3] Reduce get_current() to the asm-generic
	implementation where possible
Date: Tue, 18 May 2010 13:39:27 -0400
Message-ID: <20100518173927.GL6764@bombadil.infradead.org>
References: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:52575 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab0ERRj2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2010 13:39:28 -0400
Content-Disposition: inline
In-Reply-To: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: oleg@redhat.com, linux-arch@vger.kernel.org

On Tue, May 18, 2010 at 05:45:37PM +0100, David Howells wrote:
> Reduce get_current() to the asm-generic implementation where possible to remove
> duplicate cases.
> 
> Note that this will lose the const attribute on get_current() for ARM and
> MN10300.  This will be added back in a later patch for all architectures.
> 

Acked-by: Kyle McMartin <kyle@mcmartin.ca>

> diff --git a/arch/parisc/include/asm/current.h b/arch/parisc/include/asm/current.h
> index 0fb9338..4c51401 100644
> --- a/arch/parisc/include/asm/current.h
> +++ b/arch/parisc/include/asm/current.h
> @@ -1,15 +1 @@
> -#ifndef _PARISC_CURRENT_H
> -#define _PARISC_CURRENT_H
> -
> -#include <linux/thread_info.h>
> -
> -struct task_struct;
> -
> -static inline struct task_struct * get_current(void)
> -{
> -	return current_thread_info()->task;
> -}
> - 
> -#define current get_current()
> -
> -#endif /* !(_PARISC_CURRENT_H) */
> +#include <asm-generic/current.h>
