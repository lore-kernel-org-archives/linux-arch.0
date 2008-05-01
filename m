Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:35615 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902AbYEAMpA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 May 2008 08:45:00 -0400
Received: from [172.20.22.227]([172.20.22.227]) (1878 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>)
	id <m1JrY9U-0000Z7C@megami.veritas.com>
	for <linux-arch@vger.kernel.org>; Thu, 1 May 2008 05:44:44 -0700 (PDT)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
Date: Thu, 1 May 2008 13:45:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [rfc] data race in page table setup/walking?
In-Reply-To: <20080501003542.GB11312@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0805011342210.24147@blonde.site>
References: <20080429050054.GC21795@wotan.suse.de> <Pine.LNX.4.64.0804291333540.22025@blonde.site>
 <20080430060340.GE27652@wotan.suse.de> <Pine.LNX.4.64.0804301140490.4651@blonde.site>
 <20080501003542.GB11312@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20080501124503.r48S1_HxjCmPlZzUpSghmojY5Rxyns7rLERjbsLA54Q@z>

On Thu, 1 May 2008, Nick Piggin wrote:
> On Wed, Apr 30, 2008 at 12:14:51PM +0100, Hugh Dickins wrote:
> > On Wed, 30 Apr 2008, Nick Piggin wrote:
> > > 
> > > Actually, aside, all those smp_wmb() things in pgtable-3level.h can
> > > probably go away if we cared: because we could be sneaky and leverage
> > > the assumption that top and bottom will always be in the same cacheline
> > > and thus should be shielded from memory consistency problems :)
> > 
> > I've sometimes wondered along those lines.  But it would need
> > interrupts disabled, wouldn't it?  And could SMM mess it up?
> > And what about another CPU taking the cacheline to modify it
> > in between our two accesses?
> 
> Nothing more than could not already happen with the smp_wmb in there,
> AFAIKS.

Yes, one does wonder just what I was wondering ;)

Hugh
