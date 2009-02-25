From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove single
 ipi fallback for smp_call_function_many())
Date: Wed, 25 Feb 2009 10:25:04 -0800
Message-ID: <57C9024A16AD2D4C97DC78E552063EA36199197B@orsmsx505.amr.corp.intel.com>
References: <20090217112657.GE26402@wotan.suse.de>
 <1234923702.29823.7.camel@vayu> <20090218135945.GC23125@wotan.suse.de>
 <1234982620.29823.22.camel@vayu> <20090218191757.GD8889@elte.hu>
 <1235001314.14523.2.camel@vayu> <20090219122031.GC1703@elte.hu>
 <1235080824.14523.19.camel@vayu> <20090220105640.GE28581@elte.hu>
 <1235156214.14523.54.camel@vayu> <20090225033230.GA4611@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:39315 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758539AbZBYSn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 13:43:56 -0500
In-Reply-To: <20090225033230.GA4611@wotan.suse.de>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Oleg Nesterov <oleg@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "steiner@sgi.com" <steiner@sgi.com>

> Just if I may add something -- I would probably slightly prefer if
> you explicitly used an sfence or other serializing instruction rather
> than smp_mb(). Maybe call it wrmsr_fence() or something. Apart from
> being self documenting, and less confusing (wrmsr is not part of
> normal ordering), I assume you technically also need it on UP
> systems?

Maybe I lost track of this thread ... but isn't this code for the
"send ipi" path?  On a UP system do we use IPI to interrupt ourself?
Even if we did, presumably we can't get inconsistencies if there is
only one cpu.

-Tony
