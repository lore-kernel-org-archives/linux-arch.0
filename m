From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder cpu
 into lock
Date: Wed, 15 Jul 2020 12:33:27 -0400
Message-ID: <b16a2d2b-3c72-cb70-5b6c-2f02a0953e42@redhat.com>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
 <20200712173452.GB10769@hirez.programming.kicks-ass.net>
 <bed22603-e347-8bff-f586-072a18987946@redhat.com>
 <1594613637.ds7pt1by9l.astroid@bobo.none>
 <e850b327-d747-fbe8-95db-4e2fbb1d7871@redhat.com>
 <20200714090126.GR10769@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50166 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725838AbgGOQdg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 12:33:36 -0400
In-Reply-To: <20200714090126.GR10769@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Davidlohr Bueso <dave@stgolabs.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, x86@kernel.org

On 7/14/20 5:01 AM, Peter Zijlstra wrote:
> On Mon, Jul 13, 2020 at 10:48:00PM -0400, Waiman Long wrote:
>> Storing the cpu number into the lock can be useful for other reason too. It
>> is not totally related to PPC support.
> Well, the thing you did only works for 'small' (<253 CPU) systems.
> There's a number of Power systems that's distinctly larger than that. So
> it simply cannot work as anything other than a suggestion/hint. It must
> not be a correctness thing.
>
Yes, there are limit on how much data one can put into the lock byte. So 
it is not a sure way to find out who the lock holder is. There are 
certainly large systems with hundreds or even thousands of cpus, but 
they are the minority in the sea of Linux systems out there.

If the lock holder goes through the slowpath, the one behind it can save 
its cpu number which can be used a hint of who the lock holder is though 
it is not that reliable as lock stealing can happen.

BTW, I did get the optimized PV unlock asm code working now. I will post 
the updated unconditional patch later this week for further discussion.

Cheers,
Longman
