From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder
 cpu into lock
Date: Tue, 14 Jul 2020 11:01:26 +0200
Message-ID: <20200714090126.GR10769@hirez.programming.kicks-ass.net>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
 <20200712173452.GB10769@hirez.programming.kicks-ass.net>
 <bed22603-e347-8bff-f586-072a18987946@redhat.com>
 <1594613637.ds7pt1by9l.astroid@bobo.none>
 <e850b327-d747-fbe8-95db-4e2fbb1d7871@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNJBq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 05:01:46 -0400
Content-Disposition: inline
In-Reply-To: <e850b327-d747-fbe8-95db-4e2fbb1d7871@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Davidlohr Bueso <dave@stgolabs.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, x86@kernel.org

On Mon, Jul 13, 2020 at 10:48:00PM -0400, Waiman Long wrote:
> Storing the cpu number into the lock can be useful for other reason too. It
> is not totally related to PPC support.

Well, the thing you did only works for 'small' (<253 CPU) systems.
There's a number of Power systems that's distinctly larger than that. So
it simply cannot work as anything other than a suggestion/hint. It must
not be a correctness thing.
