Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:49134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbeBVKHD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 05:07:03 -0500
Date: Thu, 22 Feb 2018 11:06:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Message-ID: <20180222100636.GP25201@hirez.programming.kicks-ass.net>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
 <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180222032349.klcuiq23f52sfop6@tardis>
 <20180222041357.GB2855@linux.vnet.ibm.com>
 <20180222052746.vofmqbpnmfahck3z@tardis>
 <fad8e18b-ef5a-5bc0-5d87-6fad2e9f7c95@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad8e18b-ef5a-5bc0-5d87-6fad2e9f7c95@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lustig <dlustig@nvidia.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>

On Wed, Feb 21, 2018 at 09:42:08PM -0800, Daniel Lustig wrote:
> And yes, if we go with a purely RCpc interpretation of acquire and
> release, then I don't believe the writes in the previous critical
> section would be ordered with the writes in the subsequent critical
> section.

Excuse my ignorance (also jumping in the middle of things), but how can
this be?

spin_unlock() is a store-release, this means the write to the lock word
must happen after any stores inside the critical section.

spin_lock() is a load-acquire + test-and-set-ctrl-dep, we'll only
proceed with the critical section if we observe the lock 'unlocked',
which also means we must observe the stores prior to the unlock.

And both the ctrl-dep and the ACQUIRE ensure future stores cannot happen
before.

So while the lock store and subsequent critical section stores are
unordered, I don't see how it would be possible to not be ordered
against stores from a previous critical section.
