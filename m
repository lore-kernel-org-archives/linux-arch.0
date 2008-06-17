From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu operations
Date: Tue, 17 Jun 2008 10:24:40 +1000
Message-ID: <200806171024.40662.rusty@rustcorp.com.au>
References: <20080530035620.587204923@sgi.com> <200806152033.02891.rusty@rustcorp.com.au> <Pine.LNX.4.64.0806160748050.19276@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:45724 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbYFQAZA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Jun 2008 20:25:00 -0400
In-Reply-To: <Pine.LNX.4.64.0806160748050.19276@schroedinger.engr.sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Martin Peschke <mp3@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Tuesday 17 June 2008 00:52:08 Christoph Lameter wrote:
> On Sun, 15 Jun 2008, Rusty Russell wrote:
> > > 3. Some hooks for arches to override particular behavior as needed.
> > >    F.e. IA64 allocates percpu structures in a special way. x86_64
> > >    needs to do some tricks for the pda etc etc.
> >
> > IA64 is going to need some work, since dynamic percpu addresses won't be
> > able to use their pinned TLB trick to get the local version.
>
> The ia64 hook could simply return the address of percpu area that
> was reserved when the per node memory layout was generated (which happens
> very early during node bootstrap).

Apologies, this time I read the code.  I thought IA64 used the pinned TLB area 
to access per-cpu vars under some circumstances, but they only do that via an 
arch-specific macro.

So creating new congruent mappings to expand the percpu area(s) is our main 
concern now?

Rusty.
