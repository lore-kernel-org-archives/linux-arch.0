Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55158 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750888AbZGDQpM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 4 Jul 2009 12:45:12 -0400
Date: Sat, 4 Jul 2009 09:44:38 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: handle_mm_fault() calling convention cleanup..
In-Reply-To: <1246664107.7551.11.camel@pasglop>
Message-ID: <alpine.LFD.2.01.0907040937040.3210@localhost.localdomain>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain> <1246664107.7551.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <20090704164438.id6znU4ErxXdK5y3jKBqjPDttXejTW59KQIUPdwgn-A@z>



On Sat, 4 Jul 2009, Benjamin Herrenschmidt wrote:
> 
> BTW. I'd like to extend these if there's no objection one of these days
> to also pass whether it was an exec fault, and pass the full flags to
> ptep_set_access_flags().

Sure. No problem, and sounds sane.

Just a tiny word of warning: right now, the conversion I did pretty much 
depended on the fact that even if I missed a spot, it wouldn't actually 
make any difference. If somebody used "flags" as a binary value (ie like 
the old "write_access" kind of semantics), things would still all work, 
because it was still a "zero-vs-nonzero" issue wrt writes.

And there were cases in the hugepage handling that I had missed, that 
Hugh picked up. Maybe he picked them all - but be careful.

I didn't add any flags (like the FAULT_FLAG_RETRY thing that started it 
all) that would actually _require_ everybody to always treat it as a 
bitmask. And some places still pass the flags down as basically just the 
"write or not" thing. ptep_set_access_flags() stands out as one of them 
(and I think your suggestion would actually clean things up), but there 
are probably others.

		Linus
