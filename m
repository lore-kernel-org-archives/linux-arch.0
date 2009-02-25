From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] generic IPI: simplify barriers and locking
Date: Wed, 25 Feb 2009 12:28:00 +0100
Message-ID: <20090225112800.GG15453@elte.hu>
References: <20090225052244.GB22785@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:49743 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755961AbZBYL2y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Feb 2009 06:28:54 -0500
Content-Disposition: inline
In-Reply-To: <20090225052244.GB22785@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, Oleg Nesterov <oleg@redhat.com>, Suresh Siddha <suresh.b.siddha@intel.com>, linux-arch@vger.kernel.org


* Nick Piggin <npiggin@suse.de> wrote:

> OK, shall we go ahead with this? Only objection from arch guys 
> came from x86, which has since fixed up ordering of IPIs 
> versus memory operations.
> 
> It simplifies things quite a bit and I think Peter is using it 
> as a base under his remove kmalloc patchset..

Sure. I had Peter's patches in tip/core/ipi but they had test 
failures so it's still being worked out.

I've applied your patch to tip:core/ipi and will keep it there 
unless there are objections.

Thanks,

	Ingo
