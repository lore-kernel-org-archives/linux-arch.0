From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 02/31] locking,alpha: Implement
 atomic{,64}_fetch_{add,sub,and,andnot,or,xor}()
Date: Sat, 23 Apr 2016 03:55:34 +0200
Message-ID: <20160423015534.GW3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.156825130@infradead.org>
 <571A57E0.1040704@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45165 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbcDWB4V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 21:56:21 -0400
Content-Disposition: inline
In-Reply-To: <571A57E0.1040704@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Henderson <rth@twiddle.net>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On Fri, Apr 22, 2016 at 09:57:04AM -0700, Richard Henderson wrote:
> On 04/22/2016 02:04 AM, Peter Zijlstra wrote:
> > +	"1:	ldl_l %0,%1\n"						\
> > +	"       mov %0,%2\n"						\
> > +	"	" #asm_op " %0,%3,%0\n"					\
> > +	"	stl_c %0,%1\n"						\
> 
> No need for the extra mov.
> 
> 	ldl_l %2,%1
> 	asm_op %2,%3,%0
> 	stl_c %0,%1

Indeed, I got my head stuck in two operand (x86) asm. This is the second
such 'mistake', I'll go have a look at the rest too.

Thanks!
