From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Sat, 25 Jan 2020 14:57:41 -0500
Message-ID: <5ffb74f6-c635-cfc8-ab01-fb990f12a93a@redhat.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <45660873-731a-a810-8c57-1a5a19d266b4@redhat.com>
 <b26837a9-d0cd-4413-95ec-1deaca184324@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24827 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726612AbgAYT5y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 14:57:54 -0500
In-Reply-To: <b26837a9-d0cd-4413-95ec-1deaca184324@redhat.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com

On 1/24/20 1:51 PM, Waiman Long wrote:
>> You can use the in_task() macro in include/linux/preempt.h. This is
>> just a percpu preempt_count read and test. If in_task() is false, it
>> is in a {soft|hard}irq or nmi context. If it is true, you can check
>> the rt_task() macro to see if it is an RT task. That will access to
>> the current task structure. So it may cost a little bit more if you
>> want to handle the RT task the same way.
>>
> We may not need to do that for softIRQ context. If that is the case, yo=
u
> can use in_irq() which checks for hardirq and nmi only. Peter, what is
> your thought on that?

In second thought, we should do that for softIRQ as well. Also, we may
want to also check if irqs_disabled() is true as well by calls like
spin_lock_irq() or spin_lock_irqsave().=C2=A0 We do not want to unnecessa=
rily
prolong the irq off period.

Cheers,
Longman
