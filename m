Return-Path: <SRS0=uZ41=BC=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726455AbgGWTEW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 15:04:22 -0400
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
 <20200723184759.GS119549@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <6d6279ad-7432-63c1-14c3-18c4cff30bf8@redhat.com>
Date: Thu, 23 Jul 2020 15:04:13 -0400
MIME-Version: 1.0
In-Reply-To: <20200723184759.GS119549@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200723190413.uyF4C0b6Cjd2AKLFzMSm4NcDjz_ClWuDvh6vP0MzrKc@z>

On 7/23/20 2:47 PM, peterz@infradead.org wrote:
> On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
>> BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
>> I will have to update the patch to fix the reported 0-day test problem, but
>> I want to collect other feedback before sending out v3.
> I want to say I hate it all, it adds instructions to a path we spend an
> aweful lot of time optimizing without really getting anything back for
> it.

It does add some extra instruction that may slow it down slightly, but I 
don't agree that it gives nothing back. The cpu lock holder information 
can be useful in analyzing crash dumps and in some debugging situation. 
I think it can be useful in RHEL for this readon. How about an x86 
config option to allow distros to decide if they want to have it 
enabled? I will make sure that it will have no performance degradation 
if the option is not enabled.

Cheers,
Longman
