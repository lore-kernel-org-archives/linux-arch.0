Return-Path: <SRS0=Q31O=AZ=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34687 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726372AbgGNCsK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 22:48:10 -0400
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder cpu
 into lock
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
 <20200712173452.GB10769@hirez.programming.kicks-ass.net>
 <bed22603-e347-8bff-f586-072a18987946@redhat.com>
 <1594613637.ds7pt1by9l.astroid@bobo.none>
From: Waiman Long <longman@redhat.com>
Message-ID: <e850b327-d747-fbe8-95db-4e2fbb1d7871@redhat.com>
Date: Mon, 13 Jul 2020 22:48:00 -0400
MIME-Version: 1.0
In-Reply-To: <1594613637.ds7pt1by9l.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Davidlohr Bueso <dave@stgolabs.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, x86@kernel.org
Message-ID: <20200714024800.Dnl5MKoX9JfyoQcIPIef4oB4KMuoxfGVXqNev1Kbad0@z>

On 7/13/20 12:17 AM, Nicholas Piggin wrote:
> Excerpts from Waiman Long's message of July 13, 2020 9:05 am:
>> On 7/12/20 1:34 PM, Peter Zijlstra wrote:
>>> On Sat, Jul 11, 2020 at 02:21:28PM -0400, Waiman Long wrote:
>>>> The previous patch enables native qspinlock to store lock holder cpu
>>>> number into the lock word when the lock is acquired via the slowpath.
>>>> Since PV qspinlock uses atomic unlock, allowing the fastpath and
>>>> slowpath to put different values into the lock word will further slow
>>>> down the performance. This is certainly undesirable.
>>>>
>>>> The only way we can do that without too much performance impact is to
>>>> make fastpath and slowpath put in the same value. Still there is a slight
>>>> performance overhead in the additional access to a percpu variable in the
>>>> fastpath as well as the less optimized x86-64 PV qspinlock unlock path.
>>>>
>>>> A new config option QUEUED_SPINLOCKS_CPUINFO is now added to enable
>>>> distros to decide if they want to enable lock holder cpu information in
>>>> the lock itself for both native and PV qspinlocks across both fastpath
>>>> and slowpath. If this option is not configureed, only native qspinlocks
>>>> in the slowpath will put the lock holder cpu information in the lock
>>>> word.
>>> And this kills it,.. if it doesn't make unconditional sense, we're not
>>> going to do this. It's just too ugly.
>>>
>> You mean it has to be unconditional, no option config if we want to do
>> it. Right?
>>
>> It can certainly be made unconditional after I figure out how to make
>> the optimized PV unlock code work.
> Sorry I've not had a lot of time to get back to this thread and test
> things -- don't spend loads of effort or complexity on it until we get
> some more numbers. I did see some worse throughput results (with no
> attention to fairness) with the PV spin lock, but it was a really quick
> limited few tests, I need to get something a bit more substantial.
>
> I do very much appreciate your help with the powerpc patches, and
> interest in the PV issues though. I'll try to find more time to help
> out.

Native qspinlock is usually not a problem performance-wise. PV 
qspinlock, however, is usually the challenging part. It took me a long 
time to get the PV code right so that I can merge qspinlock upstream. I 
do some interest to get qspinlock used by ppc, though.

Storing the cpu number into the lock can be useful for other reason too. 
It is not totally related to PPC support.

Cheers,
Longman
