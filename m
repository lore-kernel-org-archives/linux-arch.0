From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu
 operations
Date: Thu, 29 May 2008 23:12:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805292309520.12457@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <20080530040011.727424512@sgi.com>
 <20080529215844.609a3ac8.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0805292214280.12107@schroedinger.engr.sgi.com>
 <20080529223825.bf744d37.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:34717 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752755AbYE3GNA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 02:13:00 -0400
In-Reply-To: <20080529223825.bf744d37.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

On Thu, 29 May 2008, Andrew Morton wrote:

> > area. It requies disabling of interrupts etc.
> 
> No it doesn't.  Look:
> 
> static inline void local_inc(local_t *l)
> {
> 	asm volatile(_ASM_INC "%0"
> 		     : "+m" (l->a.counter));
> }
> 
> > Its not atomic (wrt 
> > interrupts) because of that.
> >
> 
> Yes it is.

No its not! In order to increment a per cpu value you need to calculate 
the per cpu pointer address in the current per cpu segment. local_t 
cannot do that in an atomic (wrt interrupt/preempt fashion) fashion. cpu 
ops can use a segment prefix and thus the insructions can calculate the 
per cpu adress and perform the atomic inc without disabling preempt or 
interrupts.

local_t is only useful when you disable interrupt or premption otherwise. 
But then you could also use a regular increment.

> > But then its related to percpu operations and relies extensively on the 
> > various percpu.h files in asm-generic and asm-arch and include/linux
> 
> Well that should be fixed.  We should never have mixed the
> alloc_percpu() and DEFINE_PER_CPU things inthe same header.  They're
> different.

With cpu_alloc they are the same. They allocate from the same per cpu 
area.
