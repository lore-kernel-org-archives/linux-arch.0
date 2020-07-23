From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
Date: Thu, 23 Jul 2020 14:32:36 -0400
Message-ID: <845de183-56f5-2958-3159-faa131d46401@redhat.com>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21826 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726349AbgGWSco (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 14:32:44 -0400
In-Reply-To: <20200723140011.GR5523@worktop.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org

On 7/23/20 10:00 AM, Peter Zijlstra wrote:
> On Thu, Jul 09, 2020 at 12:06:13PM -0400, Waiman Long wrote:
>> We don't really need to do a pv_spinlocks_init() if pv_kick() isn't
>> supported.
> Waiman, if you cannot explain how not having kick is a sane thing, what
> are you saying here?
>
The current PPC paravirt spinlock code doesn't do any cpu kick. It does 
an equivalence of pv_wait by yielding the cpu to the lock holder only. 
The pv_spinlocks_init() is for setting up the hash table for doing 
pv_kick. If we don't need to do pv_kick, we don't need the hash table.

I am not saying that pv_kick is not needed for the PPC environment. I 
was just trying to adapt the pvqspinlock code to such an environment 
first. Further investigation on how to implement some kind of pv_kick 
will be something that we may want to do as a follow on.

BTW, do you have any comment on my v2 lock holder cpu info qspinlock 
patch? I will have to update the patch to fix the reported 0-day test 
problem, but I want to collect other feedback before sending out v3.

Cheers,
Longman
