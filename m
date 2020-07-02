Return-Path: <SRS0=qOhU=AN=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGBI2v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 04:28:51 -0400
Date: Thu, 2 Jul 2020 10:28:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/8] powerpc/pseries: use smp_rmb() in H_CONFER spin yield
Message-ID: <20200702082840.GC4781@hirez.programming.kicks-ass.net>
References: <20200702074839.1057733-1-npiggin@gmail.com>
 <20200702074839.1057733-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702074839.1057733-3-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200702082840.i3bdTUvxOyIWVNiNXZ9TIT4lBabDClRrmKf3tRqDHW0@z>

On Thu, Jul 02, 2020 at 05:48:33PM +1000, Nicholas Piggin wrote:
> There is no need for rmb(), this allows faster lwsync here.

Since you determined this; I'm thinking you actually understand the
ordering here. How about recording this understanding in a comment?

Also, should the lock->slock load not use READ_ONCE() ?
