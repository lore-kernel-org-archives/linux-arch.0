From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 9/10] parisc: convert to generic helpers for IPI  function calls
Date: Mon, 9 Jun 2008 10:47:03 +0200
Message-ID: <20080609084701.GW5757@kernel.dk>
References: <1212051504-12561-1-git-send-email-jens.axboe@oracle.com> <1212051504-12561-10-git-send-email-jens.axboe@oracle.com> <20080531070049.GA6623@phobos.i.cabal.ca> <20080602081749.GG5757@kernel.dk> <20080602160943.GB25011@phobos.i.cabal.ca> <20080606084743.GL5757@kernel.dk> <20080606211143.GA20770@phobos.i.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:12870 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756832AbYFIIrG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Jun 2008 04:47:06 -0400
Content-Disposition: inline
In-Reply-To: <20080606211143.GA20770@phobos.i.cabal.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>

On Fri, Jun 06 2008, Kyle McMartin wrote:
> On Fri, Jun 06, 2008 at 10:47:43AM +0200, Jens Axboe wrote:
> > > Thanks, I'll try it out this evening.
> > 
> > How did that go?
> > 
> 
> Ah, sorry, I forgot to mention that. Seems to be working fine, at
> least, I'm getting jobs scheduled on each cpu, afaict.
> 
> Needed this patch though, and from the looks of things, a bunch of
> other architectures will need it as well.
> 
> Signed-off-by: Kyle McMartin <kyle@mcmartin.ca>

> 
> diff --git a/include/asm-parisc/smp.h b/include/asm-parisc/smp.h
> index 306f495..ad24e7f 100644
> --- a/include/asm-parisc/smp.h
> +++ b/include/asm-parisc/smp.h
> @@ -62,4 +62,7 @@ static inline void __cpu_die (unsigned int cpu) {
>  }
>  extern int __cpu_up (unsigned int cpu);
>  
> +void arch_send_call_function_ipi(cpumask_t mask);
> +void arch_send_call_function_single_ipi(int cpu);
> +
>  #endif /*  __ASM_SMP_H */

Yeah, the very latest (not posted) needs this, as archs can now put
inline versions in asm/smp.h if they wish. I'll update parisc and
the others, thanks!

-- 
Jens Axboe
