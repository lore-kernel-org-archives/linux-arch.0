From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/10] Add generic helpers for arch IPI function calls
Date: Wed, 7 May 2008 22:42:52 +0200
Message-ID: <20080507204251.GO16217@kernel.dk>
References: <20080430123717.GC12774@kernel.dk> <20080502020241.GA26088@linux.vnet.ibm.com> <20080502021233.GC11844@wotan.suse.de> <20080502122955.GB15522@linux.vnet.ibm.com> <20080502124205.GA23680@linux.vnet.ibm.com> <1209733169.13978.157.camel@twins> <20080503054930.GA19664@wotan.suse.de> <20080503181148.GA16159@linux.vnet.ibm.com> <20080505041533.GA17640@wotan.suse.de> <20080505174312.GC7543@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:9092 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758545AbYEGUm7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 May 2008 16:42:59 -0400
Content-Disposition: inline
In-Reply-To: <20080505174312.GC7543@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu

On Mon, May 05 2008, Paul E. McKenney wrote:
> OK.  The below still permits parallel smp_call_function()
> and smp_call_function_mask() as well as permitting parallel
> smp_call_function_single().  It prohibits the irq-disabled case.
> 
> Thoughts?

Sorry for the delayed response here. The below looks pretty good to me,
though it'll require a few modifications to fixup smp_call_function()
from irq disabled context.

But that's doable, though I have to do a grep over the kernel to check
everything (I remember CPU send_stop being one such path). Not a huge
fan of such an interface, but hey...

Is everyone OK with going this route, initially at least? It's the
lesser of all evils, I think.

> diff --git a/arch/Kconfig b/arch/Kconfig
> index a5a0184..5ae9360 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -38,4 +38,4 @@ config HAVE_KRETPROBES
>  	def_bool n
>  
>  config USE_GENERIC_SMP_HELPERS
> -	def_bool n
> +	def_bool y

This part puzzled me, why? We default to 'n' and let converted archs
opt-in, so I don't get this part of your patch...

-- 
Jens Axboe
