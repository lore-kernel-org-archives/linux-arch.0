Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37877 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756374AbYD3Py1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Apr 2008 11:54:27 -0400
Date: Wed, 30 Apr 2008 08:53:44 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [rfc] data race in page table setup/walking?
In-Reply-To: <20080430060340.GE27652@wotan.suse.de>
Message-ID: <alpine.LFD.1.10.0804300848390.2997@woody.linux-foundation.org>
References: <20080429050054.GC21795@wotan.suse.de> <Pine.LNX.4.64.0804291333540.22025@blonde.site> <20080430060340.GE27652@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-arch@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20080430155344.MHyXuR0ABARV4ftfheejcpSxZain6MuYgMOSVpVDNIA@z>



On Wed, 30 Apr 2008, Nick Piggin wrote:
> 
> Actually, aside, all those smp_wmb() things in pgtable-3level.h can
> probably go away if we cared: because we could be sneaky and leverage
> the assumption that top and bottom will always be in the same cacheline
> and thus should be shielded from memory consistency problems :)

Umm.

Why would we care, since smp_wmb() is a no-op? (Yea, it's a compiler 
barrier, big deal, it's not going to cost us anything).

Also, write barriers are not about cacheline access order, they tend to be 
more about the write *buffer*, ie before the write even hits the cache 
line. And a write coudl easily pass another write in the write buffer if 
there is (for example) a dependency on the address.

So even if they are in the same cacheline, if the first write needs an 
offset addition, and the second one does not, it could easily be that the 
second one hits the write buffer first (together with some alias 
detection that re-does the things if they alias).

Of course, on x86, the write ordering is strictly defined, and even if the 
CPU reorders writes they are guaranteed to never show up re-ordered, so 
this is not an issue. But I wanted to point out that memory ordering is 
*not* just about cachelines, and being in the same cacheline is no 
guarantee of anything, even if it can have *some* effects.

		Linus
