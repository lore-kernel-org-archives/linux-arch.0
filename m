Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDCRkW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Apr 2019 13:40:22 -0400
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <9ec3d8dc-d1e0-1b8a-5e00-ba92b9756c58@redhat.com>
 <20190403171635.GM4038@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <063622f7-6aab-9824-afce-ea5de103e1f6@redhat.com>
Date: Wed, 3 Apr 2019 13:40:19 -0400
MIME-Version: 1.0
In-Reply-To: <20190403171635.GM4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190403174019.74fJEnMOOyqH0pKd5q5weyrpbrc87ZhFS6FEwreubeA@z>

On 04/03/2019 01:16 PM, Peter Zijlstra wrote:
> On Wed, Apr 03, 2019 at 12:33:20PM -0400, Waiman Long wrote:
>> static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32
>> val)
>> {
>>         if (static_branch_unlikely(&use_numa_spinlock))
>>                 numa_queued_spin_lock_slowpath(lock, val);
>>         else   
>>                 native_queued_spin_lock_slowpath(lock, val);
>> }
> That's horrible for the exact reason you state.
>
>> Alternatively, we can also call numa_queued_spin_lock_slowpath() in
>> native_queued_spin_lock_slowpath() if we don't want to increase the code
>> size of spinlock call sites.
> Yeah, still don't much like that though, we're littering the fast path
> of that slow path with all sorts of crap.

Yes, I know it is less than ideal, but that is probably the only option
if we don't have static_call or paravirt. On the other hand, I am
perfectly fine with making CNA depends on PARAVIRT_SPINLOCKS for now
until static_call is available.

Cheers,
Longman
