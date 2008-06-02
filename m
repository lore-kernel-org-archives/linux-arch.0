From: Paul Jackson <pj@sgi.com>
Subject: Re: [patch 02/41] cpu alloc: The allocator
Date: Mon, 2 Jun 2008 04:29:46 -0500
Message-ID: <20080602042946.1f27faf3.pj@sgi.com>
References: <20080530035620.587204923@sgi.com>
	<20080530040011.084909898@sgi.com>
	<20080529215833.469c3cbe.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0805292203240.12107@schroedinger.engr.sgi.com>
	<20080529223109.bbb7b0e0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:57905 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750986AbYFBJ3v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2008 05:29:51 -0400
In-Reply-To: <20080529223109.bbb7b0e0.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: clameter@sgi.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, dada1@cosmosbay.com, peterz@infradead.org, rusty@rustcorp.com.au, travis@sgi.com

Andrew wrote:
> > > > +#define CPU_PTR(__p, __cpu)	SHIFT_PERCPU_PTR((__p), per_cpu_offset(__cpu))
> > > 
> > > eek, a major interface function which is ALL IN CAPS!
> > > 
> > > can we do this in lower-case?  In a C function?
> > 
> > No. This is a macro and therefore uppercase (there is macro magic going on 
> > that ppl need to be aware of). AFAICR you wanted it this way last year. C 
> > function not possible because of the type checking.
> 
> urgh.  This is a C-convention versus kernel-convention thing.  The C
> convention exists for very good reasons.  But it sure does suck.
> 
> What do others think?

A few, key symbols get to be special ... short but distinctive names
that become (in)famous.  The classic was "u", for the per-user
structure, aka the "user area", in old Unix kernels.  In people's
names, a few one word or first names such as "Ike", "Madonna", "Ali",
"Tiger", "Cher", "Mao", "OJ", "Plato", "Linus", ... have become
distinctive and well known to many people.

How about "_pcpu", instead of CPU_PTR?  "_pcpu" is a short, unique
(not currently in use) symbol that, tersely, says what we want to say.

Yes - it violates multiple conventions.  "The Boss" (Bruce Springsteen)
gets to do that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.940.382.4214
