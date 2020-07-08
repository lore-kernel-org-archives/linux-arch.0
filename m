Return-Path: <SRS0=HA2T=AT=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from casper.infradead.org ([90.155.50.34]:57900 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGHIpK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 04:45:10 -0400
Date: Wed, 8 Jul 2020 10:32:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Message-ID: <20200708083210.GD597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
Message-ID: <20200708083210.YaKnbYhBr1mDlFBMk-e2iKDDkeNQ9Xv6vawgLI7Kzu8@z>

On Tue, Jul 07, 2020 at 11:33:45PM -0400, Waiman Long wrote:
> From 5d7941a498935fb225b2c7a3108cbf590114c3db Mon Sep 17 00:00:00 2001
> From: Waiman Long <longman@redhat.com>
> Date: Tue, 7 Jul 2020 22:29:16 -0400
> Subject: [PATCH 2/9] locking/pvqspinlock: Introduce
>  CONFIG_PARAVIRT_QSPINLOCKS_LITE
> 
> Add a new PARAVIRT_QSPINLOCKS_LITE config option that allows
> architectures to use the PV qspinlock code without the need to use or
> implement a pv_kick() function, thus eliminating the atomic unlock
> overhead. The non-atomic queued_spin_unlock() can be used instead.
> The pv_wait() function will still be needed, but it can be a dummy
> function.
> 
> With that option set, the hybrid PV queued/unfair locking code should
> still be able to make it performant enough in a paravirtualized

How is this supposed to work? If there is no kick, you have no control
over who wakes up and fairness goes out the window entirely.

You don't even begin to explain...
