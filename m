From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Subject: Re: [PATCH/RFC 1/6] numa: Use Generic Per-cpu Variables for
 numa_node_id()
Date: Wed, 02 Dec 2009 11:29:21 -0500
Message-ID: <1259771361.4088.25.camel@useless.americas.hpqcorp.net>
References: <20091113211714.15074.29078.sendpatchset@localhost.localdomain>
	 <alpine.DEB.1.10.0911201044320.25879@V090114053VZO-1>
	 <1259612920.4663.156.camel@useless.americas.hpqcorp.net>
	 <200912010043.36115.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:33028 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbZLBQ3S (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2009 11:29:18 -0500
In-Reply-To: <200912010043.36115.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Lameter <cl@linux-foundation.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com, Tejun Heo <tj@kernel.org>

On Tue, 2009-12-01 at 00:43 +0100, Arnd Bergmann wrote:
> On Monday 30 November 2009, Lee Schermerhorn wrote:
> > Looking at other asm/foo.h and asm-generic/foo.h relationships, I see
> > that some define the generic version of the api in the asm-generic
> > header if the arch asm header hasn't already defined it.  asm/topology.h
> > is an instance of this.  It includes asm-generic/topology.h after
> > defining arch specific versions of some of the api.
> 
> This works alright, but if you expect every architecture to include the
> asm-generic version, you might just as well take that choice away from
> the architecture and put the common code into the linux/foo.h file,
> which you can still override with definitions in asm/foo.h.
> 
> Most of the asm-generic headers are just mostly generic, and get included
> by some but not all architectures, the others defining the whole contents
> of the asm-generic file themselves in a different way.
> 
> So if you e.g. want ia64 to do everything itself and all other architectures to
> share some or all parts of asm-generic/topology, your approach is right,
> otherwise just leave the code in some file in include/linux/.

Actually, I just wanted to make the generic definitions of
this_cpu_{read|write}() visible to topology.h when building on ia64 w/o
the circular header dependencies.  Willy pointed out a way to do this by
un-inlining __alloc_percpu().  Perhaps this is the way to go.  Tejun is
looking at the patches.

Lee
