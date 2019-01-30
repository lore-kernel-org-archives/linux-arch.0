From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 0/4] locking/qspinlock: Handle > 4 nesting levels
Date: Wed, 30 Jan 2019 11:25:25 -0500
Message-ID: <cfb25527-01fc-d51f-b4fb-ea1a6cb90c99@redhat.com>
References: <1548798828-16156-1-git-send-email-longman@redhat.com>
 <20190130140707.GC2296@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130140707.GC2296@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>
List-Id: linux-arch.vger.kernel.org

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
