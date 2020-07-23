From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for SPLPAR
Date: Thu, 23 Jul 2020 15:30:46 -0500
Message-ID: <20200723203046.GI32057@gate.crashing.org>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-6-npiggin@gmail.com> <874kqhvu1v.fsf@mpe.ellerman.id.au> <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com> <20200723140011.GR5523@worktop.programming.kicks-ass.net> <845de183-56f5-2958-3159-faa131d46401@redhat.com> <20200723184759.GS119549@hirez.programming.kicks-ass.net> <6d6279ad-7432-63c1-14c3-18c4cff30bf8@redhat.com> <20200723195855.GU119549@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51798 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgGWUbE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 16:31:04 -0400
Content-Disposition: inline
In-Reply-To: <20200723195855.GU119549@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, kvm-ppc@vger.kernel.org, Will Deacon <will@kernel.org>

On Thu, Jul 23, 2020 at 09:58:55PM +0200, peterz@infradead.org wrote:
> 	asm ("addb	%[val], %b[var];"
> 	     "cmovc	%[sat], %[var];"
> 	     : [var] "+r" (tmp)
> 	     : [val] "ir" (val), [sat] "r" (sat)
> 	     );

"var" (operand 0) needs an earlyclobber ("sat" is read after "var" is
written for the first time).


Segher
