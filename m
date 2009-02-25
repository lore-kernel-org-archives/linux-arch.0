From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] generic IPI: simplify barriers and locking
Date: Wed, 25 Feb 2009 12:32:37 +0100
Message-ID: <1235561557.4645.3247.camel@laptop>
References: <20090225052244.GB22785@wotan.suse.de>
	 <20090225112800.GG15453@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57844 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756750AbZBYLda (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 06:33:30 -0500
In-Reply-To: <20090225112800.GG15453@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, Oleg Nesterov <oleg@redhat.com>, Suresh Siddha <suresh.b.siddha@intel.com>, linux-arch@vger.kernel.org

On Wed, 2009-02-25 at 12:28 +0100, Ingo Molnar wrote:
> * Nick Piggin <npiggin@suse.de> wrote:
> 
> > OK, shall we go ahead with this? Only objection from arch guys 
> > came from x86, which has since fixed up ordering of IPIs 
> > versus memory operations.
> > 
> > It simplifies things quite a bit and I think Peter is using it 
> > as a base under his remove kmalloc patchset..
> 
> Sure. I had Peter's patches in tip/core/ipi but they had test 
> failures so it's still being worked out.

You never had these latest few I think. Let me repost them.
