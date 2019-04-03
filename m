Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:41786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCRQt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 13:16:49 -0400
Date: Wed, 3 Apr 2019 19:16:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190403171635.GM4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <9ec3d8dc-d1e0-1b8a-5e00-ba92b9756c58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ec3d8dc-d1e0-1b8a-5e00-ba92b9756c58@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190403171635.wkDc8881XOlxxAeF67Ow576HiK8H4NuOqouAZYgrXBA@z>

On Wed, Apr 03, 2019 at 12:33:20PM -0400, Waiman Long wrote:
> static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32
> val)
> {
>         if (static_branch_unlikely(&use_numa_spinlock))
>                 numa_queued_spin_lock_slowpath(lock, val);
>         else   
>                 native_queued_spin_lock_slowpath(lock, val);
> }

That's horrible for the exact reason you state.

> Alternatively, we can also call numa_queued_spin_lock_slowpath() in
> native_queued_spin_lock_slowpath() if we don't want to increase the code
> size of spinlock call sites.

Yeah, still don't much like that though, we're littering the fast path
of that slow path with all sorts of crap.
