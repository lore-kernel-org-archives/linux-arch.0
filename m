Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfA3QZ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Jan 2019 11:25:28 -0500
Subject: Re: [PATCH v3 0/4] locking/qspinlock: Handle > 4 nesting levels
References: <1548798828-16156-1-git-send-email-longman@redhat.com>
 <20190130140707.GC2296@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <cfb25527-01fc-d51f-b4fb-ea1a6cb90c99@redhat.com>
Date: Wed, 30 Jan 2019 11:25:25 -0500
MIME-Version: 1.0
In-Reply-To: <20190130140707.GC2296@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>
Message-ID: <20190130162525.wA5xa2jeU2y_FA6SmbUWIAvk3SzO_JGKgbY5iGeZGt4@z>

On 01/30/2019 09:07 AM, Peter Zijlstra wrote:
>> Waiman Long (4):
>>   locking/qspinlock: Handle > 4 slowpath nesting levels
>>   locking/qspinlock_stat: Track the no MCS node available case
> I've taken these two,
>
>>   locking/qspinlock_stat: Introduce a generic lockevent counting APIs
>>   locking/lock_events: Make lock_events available for all archs & other
>>     locks
> while no real objection to these; I feel we should wait until there are
> in fact more users of this.

I am actually working on a rwsem patch which I plan to use the event
counting for my testing purpose. I will include this two patches in my
patch series.

Thanks,
Longman
