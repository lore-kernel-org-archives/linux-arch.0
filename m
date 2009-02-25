From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] generic IPI: simplify barriers and locking
Date: Wed, 25 Feb 2009 13:23:47 +0100
Message-ID: <20090225122347.GA26273@elte.hu>
References: <20090225052244.GB22785@wotan.suse.de> <20090225112800.GG15453@elte.hu> <1235561557.4645.3247.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:37150 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756320AbZBYMY0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Feb 2009 07:24:26 -0500
Content-Disposition: inline
In-Reply-To: <1235561557.4645.3247.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, Oleg Nesterov <oleg@redhat.com>, Suresh Siddha <suresh.b.siddha@intel.com>, linux-arch@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Wed, 2009-02-25 at 12:28 +0100, Ingo Molnar wrote:
> > * Nick Piggin <npiggin@suse.de> wrote:
> > 
> > > OK, shall we go ahead with this? Only objection from arch guys 
> > > came from x86, which has since fixed up ordering of IPIs 
> > > versus memory operations.
> > > 
> > > It simplifies things quite a bit and I think Peter is using it 
> > > as a base under his remove kmalloc patchset..
> > 
> > Sure. I had Peter's patches in tip/core/ipi but they had test 
> > failures so it's still being worked out.
> 
> You never had these latest few I think. Let me repost them.

yeah, it was the initial version from a week ago or so.

	Ingo
