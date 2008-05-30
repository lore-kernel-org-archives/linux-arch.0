From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu operations
Date: Fri, 30 May 2008 17:08:50 +1000
Message-ID: <200805301708.51284.rusty@rustcorp.com.au>
References: <20080530035620.587204923@sgi.com> <20080529223825.bf744d37.akpm@linux-foundation.org> <Pine.LNX.4.64.0805292309520.12457@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:48590 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbYE3HKC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 03:10:02 -0400
In-Reply-To: <Pine.LNX.4.64.0805292309520.12457@schroedinger.engr.sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Friday 30 May 2008 16:12:59 Christoph Lameter wrote:
> On Thu, 29 May 2008, Andrew Morton wrote:
> > > area. It requies disabling of interrupts etc.
> >
> > No it doesn't.  Look:
> >
> > static inline void local_inc(local_t *l)
> > {
> > 	asm volatile(_ASM_INC "%0"
> >
> > 		     : "+m" (l->a.counter));
> >
> > }
> >
> > > Its not atomic (wrt
> > > interrupts) because of that.
> >
> > Yes it is.
>
> No its not! In order to increment a per cpu value you need to calculate
> the per cpu pointer address in the current per cpu segment.

Christoph, you just missed it, that's all.  Look at cpu_local_read et al in 
include/asm-i386/local.h (ie. before the x86 mergers chose the lowest common 
denominator one).

Cheers,
Rusty.
