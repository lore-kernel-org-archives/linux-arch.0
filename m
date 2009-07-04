From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: handle_mm_fault() calling convention cleanup..
Date: Sun, 05 Jul 2009 07:08:38 +1000
Message-ID: <1246741718.7551.22.camel@pasglop>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
	 <1246664107.7551.11.camel@pasglop>
	 <alpine.LFD.2.01.0907040937040.3210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LFD.2.01.0907040937040.3210@localhost.localdomain>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-arch.vger.kernel.org

On Sat, 2009-07-04 at 09:44 -0700, Linus Torvalds wrote:

> Just a tiny word of warning: right now, the conversion I did pretty much 
> depended on the fact that even if I missed a spot, it wouldn't actually 
> make any difference. If somebody used "flags" as a binary value (ie like 
> the old "write_access" kind of semantics), things would still all work, 
> because it was still a "zero-vs-nonzero" issue wrt writes.

 .../...

Right. Oh well.. we'll see when I get to it. I have a few higher
priority things on my pile at the moment.

Cheers,
Ben.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
