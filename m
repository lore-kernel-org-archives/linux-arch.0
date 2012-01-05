From: Christoph Lameter <cl@linux.com>
Subject: Re: [GIT PULL] slab fixes for 3.2-rc4
Date: Thu, 5 Jan 2012 13:15:27 -0600 (CST)
Message-ID: <alpine.DEB.2.00.1201051210040.25706@router.home>
References: <alpine.LFD.2.02.1111292001420.4019@tux.localdomain> <CAOJsxLEHT4D4rfMvWe5iPFpunOaLWZD9fJxbOJ6_qMwt_rd7eg@mail.gmail.com> <20111220162315.GC10752@google.com> <CA+55aFwwjAtiiM5V3LfebmtKAOzxZXk-VzJ3U7PJAc1VjxK69Q@mail.gmail.com>
 <20111220202854.GH10752@google.com> <alpine.DEB.2.00.1112210851230.9601@router.home> <20111221170535.GB9213@google.com> <alpine.DEB.2.00.1112220854440.31315@router.home> <20111222160822.GE17084@google.com> <alpine.DEB.2.00.1112221154380.11787@router.home>
 <CA+55aFzY_6QYVyjAmP+w8D0Xy1Pq++XEUaBJRcCN9SbDE-pOhw@mail.gmail.com> <alpine.DEB.2.00.1112231031001.3482@router.home> <CA+55aFzCY7TyEgkWFn6wxUMjBBaKGcx0hdV6gTdta5u8eK=Ymg@mail.gmail.com> <alpine.DEB.2.00.1201040906090.27157@router.home>
 <CA+55aFwOp1UbeexKSdQC6YwrA9pS-J5qdqs-68=H8T1GS4Nr1A@mail.gmail.com> <alpine.DEB.2.00.1201041046290.29775@router.home> <CA+55aFwgN4QGowU1+5NO0QWr4nT9KDyk8opiVgzmULJG-2eKzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp109.prem.mail.ac4.yahoo.com ([76.13.13.92]:23810 "HELO
	smtp109.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757289Ab2AETPb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2012 14:15:31 -0500
In-Reply-To: <CA+55aFwgN4QGowU1+5NO0QWr4nT9KDyk8opiVgzmULJG-2eKzg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Wed, 4 Jan 2012, Linus Torvalds wrote:

> On Wed, Jan 4, 2012 at 9:00 AM, Christoph Lameter <cl@linux.com> wrote:
> >
> > xadd is 3 cycles. add is one cycle.
>
> On some uarchs. On new uarchs it can be a single cycle, I think, and
> on some uarchs it will even be microcoded and/or only go in one pipe
> because it has that odd behavior that it writes both to memory and a
> register, and thus doesn't fit the normal fastpaths.

> The point is, xadd isn't actually any faster than just doing the
> regular "add and read". It's *slower*.

Ok that assumes that both add and read are this_cpu operations that
use the segment override to relocate the address. I thought you wanted to
open code everything. So then we would have to use the following?

	this_cpu_add(var, count);
	result = this_cpu_read(var);


XADD and ADD have the same cycle count if the ADD is used to add to a
memory location. Both use 4 microops.

The MOVE from memory costs another 2 so we are at 6. Two segment overrides
for each instruction add 2 more (nothing in the optimization manual but as
far as I can recall another uop is needed for the address calculation). So
this ends up at 8.

On the other hand

	result = this_cpu_add_return(var, count)

is 4 + 1.
