From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu operations
Date: Wed, 11 Jun 2008 21:10:56 +1000
Message-ID: <200806112110.56805.rusty@rustcorp.com.au>
References: <20080530035620.587204923@sgi.com> <200806021200.41652.rusty@rustcorp.com.au> <Pine.LNX.4.64.0806101034480.17131@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:34911 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbYFKLLJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jun 2008 07:11:09 -0400
In-Reply-To: <Pine.LNX.4.64.0806101034480.17131@schroedinger.engr.sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Wednesday 11 June 2008 03:42:15 Christoph Lameter wrote:
> 1. The x86 implementation does not exist because the segment register has
>    so far not been available on x86_64. So you could not do the solution.
>    You need the zero basing. Then you can use per_xxx_add in cpu_inc.

Yes: for 64 bit x86, getting rid of the PDA or zero-basing is required.

> 2. The general solution created overhead that is often not needed. If we
>    would have done vm event counters with local_t then we would have
>    atomic overhead for each increment on f.e. IA64. That was not
>    acceptable. cpu_alloc never falls back to atomic operations.

You can implement it either way.  I've said that three times now.  The current 
generic one uses atomics, but preempt disable/enable is possible.

> 3. local_t is based on the atomic logic. But percpu handling is
>    fundamentally different in that accesses without the special macros
>    are okay provided you are in a non preemptible or irq context!
>    A local_t declaration makes such accesses impossible.

Again, untrue.  The interface is already there.  So feel free to implement 
__cpu_local_inc et al in terms of preempt enable and disable so it doesn't 
need to use atomics.  

> 4. The modeling of local_t on atomic_t limits it to 32bit!

Again wrong.  And adding an exclamation mark doesn't make it true.

Rusty.
