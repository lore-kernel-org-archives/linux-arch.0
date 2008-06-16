From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu
 operations
Date: Mon, 16 Jun 2008 07:52:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806160748050.19276@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <200806131038.12987.rusty@rustcorp.com.au>
 <Pine.LNX.4.64.0806121921260.4570@schroedinger.engr.sgi.com>
 <200806152033.02891.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:60826 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752257AbYFPOwN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jun 2008 10:52:13 -0400
In-Reply-To: <200806152033.02891.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Martin Peschke <mp3@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Sun, 15 Jun 2008, Rusty Russell wrote:

> > 3. Some hooks for arches to override particular behavior as needed.
> >    F.e. IA64 allocates percpu structures in a special way. x86_64
> >    needs to do some tricks for the pda etc etc.
> 
> IA64 is going to need some work, since dynamic percpu addresses won't be able 
> to use their pinned TLB trick to get the local version.

The ia64 hook could simply return the address of percpu area that 
was reserved when the per node memory layout was generated (which happens 
very early during node bootstrap).
