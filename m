Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:41357 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbYD2WrM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Apr 2008 18:47:12 -0400
Received: from [172.20.21.109]([172.20.21.109]) (2092 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>)
	id <m1Jqyaz-0000D1C@megami.veritas.com>
	for <linux-arch@vger.kernel.org>; Tue, 29 Apr 2008 15:46:45 -0700 (PDT)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
Date: Tue, 29 Apr 2008 23:47:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [rfc] data race in page table setup/walking?
In-Reply-To: <1209505059.18023.193.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0804292328110.23470@blonde.site>
References: <20080429050054.GC21795@wotan.suse.de>
 <Pine.LNX.4.64.0804291333540.22025@blonde.site> <1209505059.18023.193.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nick Piggin <npiggin@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>
Message-ID: <20080429224704.tL2OfoT4xBFzvFh-7ZlJWMIALVvZhabar4W-fQ884rs@z>

On Wed, 30 Apr 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-04-29 at 13:36 +0100, Hugh Dickins wrote:
> > 
> > Ugh.  It's just so irritating to introduce these blockages against
> > such a remote possibility (but there again, that's what so much of
> > kernel code has to be about).  Is there any other way of handling it?
> 
> Not that much overhead... I think smp_read_barrier_depends() is a nop on
> most archs no ? The data dependency between all the pointers takes care
> of ordering in many cases.

Ah, you're right, I was automatically thinking smp_rmb, whereas as this
is the only_does_something_on_alpha_mb (nice to see those impressively
long comments on a "do { } while (0)" in some of the other arches ;)

(Well, frv says "barrier()" for it - does it actually need that?)

Yes, that's not bad at all; though in that case,
I am surprised it's enough to patch up the issue.

> So it boils down to smp_wmb's when setting
> which is not that expensive.

Yes, I wasn't worried about the much less common and anyway heavier
write (allocate) path, I don't begrudge the smp_wmb's there.

Thanks for calming me down!
Hugh
