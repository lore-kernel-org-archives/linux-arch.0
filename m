From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu operations
Date: Fri, 30 May 2008 16:32:07 +1000
Message-ID: <200805301632.07811.rusty@rustcorp.com.au>
References: <20080530035620.587204923@sgi.com> <20080529215844.609a3ac8.akpm@linux-foundation.org> <Pine.LNX.4.64.0805292214280.12107@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:60241 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbYE3GcN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 02:32:13 -0400
In-Reply-To: <Pine.LNX.4.64.0805292214280.12107@schroedinger.engr.sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Friday 30 May 2008 15:17:55 Christoph Lameter wrote:
> On Thu, 29 May 2008, Andrew Morton wrote:
> > > 	local_irq_save(flags);
> > > 	/* Calculate address of per processor area */
> > > 	p = CPU_PTR(stat, smp_processor_id());
> > > 	p->counter++;
> > > 	local_irq_restore(flags);
> >
> > eh?  That's what local_t is for?
>
> No that is what local_t exactly cannot do.

Yes, but this is local_t for dynamically allocated per-cpu vars.  You've lost 
potential symmetry and invented a whole new nomenclature :(

local_ptr_inc() etc would be far preferable IMHO.

Cheers,
Rusty.
