Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34433 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcB2R5P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 12:57:15 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.20.1602291825401.20277@wotan.suse.de>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
	<20160220021516.4898897.32908.5212@gmail.com>
	<20160220195318.GF3522@linux.vnet.ibm.com>
	<CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
	<20160227170615.GU3522@linux.vnet.ibm.com>
	<CA+55aFyHmykKc=YybJMo9ZUO352MY5noJVB4-K1Lkjmw4UHXfA@mail.gmail.com>
	<20160227231033.GW3522@linux.vnet.ibm.com>
	<20160228082702.GA300@x4>
	<CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
	<alpine.LSU.2.20.1602291825401.20277@wotan.suse.de>
Date: Mon, 29 Feb 2016 09:57:13 -0800
Message-ID: <CA+55aFy0RnpxjK7e3ScHpvwesyuXz8AWaPaTy=4QbcPV7dRKqw@mail.gmail.com>
Subject: Re: [isocpp-parallel] Proposal for new memory_order_consume definition
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Matz <matz@suse.de>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, parallel@lists.isocpp.org, llvm-dev@lists.llvm.org, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Maranget <luc.maranget@inria.fr>, Andrew Morton <akpm@linux-foundation.org>, Jade Alglave <j.alglave@ucl.ac.uk>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20160229175713.hyDJA0WX3-gfab2nnoYcen-hqYrPr6d89hslRqDkb0U@z>

On Mon, Feb 29, 2016 at 9:37 AM, Michael Matz <matz@suse.de> wrote:
>
>The important part is with induction variables controlling
> loops:
>
>   short i;  for (i = start; i < end; i++)
> vs.
>   unsigned short u; for (u = start; u < end; u++)
>
> For the former you're allowed to assume that the loop will terminate, and
> that its iteration count is easily computable.  For the latter you get
> modulo arithmetic and (if start/end are of larger type than u, say 'int')
> it might not even terminate at all.  That has direct consequences of
> vectorizability of such loops (or profitability of such transformation)
> and hence quite important performance implications in practice.

Stop bullshitting me.

It would generally force the compiler to add a few extra checks when
you do vectorize (or, more generally, do any kind of loop unrolling),
and yes, it would make things slightly more painful. You might, for
example, need to add code to handle the wraparound and have a more
complex non-unrolled head/tail version for that case.

In theory you could do a whole "restart the unrolled loop around the
index wraparound" if you actually cared about the performance of such
a case - but since nobody would ever care about that, it's more likely
that you'd just do it with a non-unrolled fallback (which would likely
be identical to the tail fixup).

It would be painful, yes.

But it wouldn't be fundamentally hard, or hurt actual performance fundamentally.

It would be _inconvenient_ for compiler writers, and the bad ones
would argue vehemently against it.

.. and it's how a "go fast" mode would be implemented by a compiler
writer initially as a compiler option, for those HPC people. Then you
have a use case and implementation example, and can go to the
standards body and say "look, we have people who use this already, it
breaks almost no code, and it makes our compiler able to generate much
faster code".

Which is why the standard was written to be good for compiler writers,
not actual users.

Of course, in real life HPC performance is often more about doing the
cache blocking etc, and I've seen people move to more parameterized
languages rather than C to get best performance. Generate the code
from a much higher-level description, and be able to do a much better
job, and leave C to do the low-level job, and let people do the
important part.

But no. Instead the C compiler people still argue for bad features
that were a misdesign and a wart on the language.

At the very least it should have been left as a "go unsafe, go fast"
option, and standardize *that*, instead of screwing everybody else
over.

The HPC people end up often using those anyway, because it turns out
that they'll happily get rid of proper rounding etc if it buys them a
couple of percent on their workload.  Things like "I really want you
to generate multiply-accumulate instructions because I don't mind
having intermediates with higher precision" etc.

             Linus
