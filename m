Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35797 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbZGFLx4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Jul 2009 07:53:56 -0400
Date: Mon, 6 Jul 2009 13:53:58 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: Re: handle_mm_fault() calling convention cleanup..
Message-ID: <20090706115358.GO2714@wotan.suse.de>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain> <1246664107.7551.11.camel@pasglop> <alpine.LFD.2.01.0907040937040.3210@localhost.localdomain> <1246741718.7551.22.camel@pasglop> <20090706073148.GJ2714@wotan.suse.de> <1246877776.22625.39.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246877776.22625.39.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <20090706115358.5qwGilO86PkzRjmd36dVtcetetnLFDWKGoWKij6wsd4@z>

On Mon, Jul 06, 2009 at 08:56:16PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2009-07-06 at 09:31 +0200, Nick Piggin wrote:
> > I have no problems with that. I'd always intended to have flags
> > go further up the call chain like Linus did (since we'd discussed
> > perhaps making faults interruptible and requiring an extra flag
> > to distinguish get_user_pages callers that were not interruptible).
> > 
> > So yes adding more flags to improve code or make things simpler
> > is fine by me :)
> > 
> That's before you see my evil plan of bringing the flags all the way
> down to set_pte_at() :-)

So long as it can be nooped out of x86 I don't see it being
a problem.

One problem x86 has with the mm/memory.c code is that it
runs out of registers (especially in fork/exit iirc). So
I wouldn't like to add unnecessary arguments to functions
if they cannot be optimised away.


