Return-Path: <SRS0=HA2T=AT=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41571 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725982AbgGHXym (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 19:54:42 -0400
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <20200708084106.GE597537@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <a9834278-25bf-90e9-10f2-cd10e5407ff6@redhat.com>
Date: Wed, 8 Jul 2020 19:54:34 -0400
MIME-Version: 1.0
In-Reply-To: <20200708084106.GE597537@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
Message-ID: <20200708235434.OP5jBdVvWiK6UbTnqjtuBbVTfLvYsVPWNhbNvKo5zUc@z>

On 7/8/20 4:41 AM, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
>> Yes, powerpc could certainly get more performance out of the slow
>> paths, and then there are a few parameters to tune.
> Can you clarify? The slow path is already in use on ARM64 which is weak,
> so I doubt there's superfluous serialization present. And Will spend a
> fair amount of time on making that thing guarantee forward progressm, so
> there just isn't too much room to play.
>
>> We don't have a good alternate patching for function calls yet, but
>> that would be something to do for native vs pv.
> Going by your jump_label implementation, support for static_call should
> be fairly straight forward too, no?
>
>    https://lkml.kernel.org/r/20200624153024.794671356@infradead.org
>
Speaking of static_call, I am also looking forward to it. Do you have an 
idea when that will be merged?

Cheers,
Longman
