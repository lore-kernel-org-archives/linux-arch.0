Return-Path: <SRS0=HA2T=AT=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725982AbgGHXxL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 19:53:11 -0400
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
 <20200708083210.GD597537@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <72f7df33-ab58-2e58-7981-cf02b6638c5b@redhat.com>
Date: Wed, 8 Jul 2020 19:53:04 -0400
MIME-Version: 1.0
In-Reply-To: <20200708083210.GD597537@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
Message-ID: <20200708235304.ULgb3g5zzhW5Puj985qLbINbPWejrkkuA7mIOXyEmzo@z>

On 7/8/20 4:32 AM, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 11:33:45PM -0400, Waiman Long wrote:
>>  From 5d7941a498935fb225b2c7a3108cbf590114c3db Mon Sep 17 00:00:00 2001
>> From: Waiman Long <longman@redhat.com>
>> Date: Tue, 7 Jul 2020 22:29:16 -0400
>> Subject: [PATCH 2/9] locking/pvqspinlock: Introduce
>>   CONFIG_PARAVIRT_QSPINLOCKS_LITE
>>
>> Add a new PARAVIRT_QSPINLOCKS_LITE config option that allows
>> architectures to use the PV qspinlock code without the need to use or
>> implement a pv_kick() function, thus eliminating the atomic unlock
>> overhead. The non-atomic queued_spin_unlock() can be used instead.
>> The pv_wait() function will still be needed, but it can be a dummy
>> function.
>>
>> With that option set, the hybrid PV queued/unfair locking code should
>> still be able to make it performant enough in a paravirtualized
> How is this supposed to work? If there is no kick, you have no control
> over who wakes up and fairness goes out the window entirely.
>
> You don't even begin to explain...
>
I don't have a full understanding of how the PPC hypervisor work myself. 
Apparently, a cpu kick may not be needed.

This is just a test patch to see if it yields better result. It is 
subjected to further modifcation.

Cheers,
Longman
