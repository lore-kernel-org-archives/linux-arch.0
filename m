From: Michael Matz <matz@suse.de>
Subject: Re: [isocpp-parallel] Proposal for new memory_order_consume
 definition
Date: Mon, 29 Feb 2016 18:37:02 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1602291825401.20277@wotan.suse.de>
References: <20160218011033.GA1505@linux.vnet.ibm.com> <20160220021516.4898897.32908.5212@gmail.com> <20160220195318.GF3522@linux.vnet.ibm.com> <CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com> <20160227170615.GU3522@linux.vnet.ibm.com>
 <CA+55aFyHmykKc=YybJMo9ZUO352MY5noJVB4-K1Lkjmw4UHXfA@mail.gmail.com> <20160227231033.GW3522@linux.vnet.ibm.com> <20160228082702.GA300@x4> <CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44502 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbcB2RhF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Feb 2016 12:37:05 -0500
In-Reply-To: <CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, parallel@lists.isocpp.org, llvm-dev@lists.llvm.org, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Maranget <luc.maranget@inria.fr>, Andrew Morton <akpm@linux-foundation.org>, Jade Alglave <j.alglave@ucl.ac.uk>, Ingo Molnar <mingo@kernel.org>

Hi,

On Sun, 28 Feb 2016, Linus Torvalds wrote:

> > So the kernel obviously is already using its own C dialect, that is 
> > pretty far from standard C. All these options also have a negative 
> > impact on the performance of the generated code.
> 
> They really don't.

They do.

> Have you ever seen code that cared about signed integer overflow?
> 
> Yeah, getting it right can make the compiler generate an extra ALU
> instruction once in a blue moon, but trust me - you'll never notice.
> You *will* notice when you suddenly have a crash or a security issue
> due to bad code generation, though.

No, that's not at all the important piece of making signed overflow 
undefined.  The important part is with induction variables controlling 
loops:

  short i;  for (i = start; i < end; i++)
vs.
  unsigned short u; for (u = start; u < end; u++)

For the former you're allowed to assume that the loop will terminate, and 
that its iteration count is easily computable.  For the latter you get 
modulo arithmetic and (if start/end are of larger type than u, say 'int') 
it might not even terminate at all.  That has direct consequences of 
vectorizability of such loops (or profitability of such transformation) 
and hence quite important performance implications in practice.  Not for 
the kernel of course.  Now we can endlessly debate how (non)practical it 
is to write HPC code in C or C++, but there we are.

> The fact is, undefined compiler behavior is never a good idea. Not for 
> serious projects.

Perhaps if these undefinednesses wouldn't have been put into the standard, 
people wouldn't have written HPC code, and if that were so the world would 
be a nicer place sometimes (certainly for the compiler).  Alas, it isn't.


Ciao,
Michael.
