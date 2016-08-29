Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-he1eur01on0086.outbound.protection.outlook.com ([104.47.0.86]:6276
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753429AbcH3BUv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Aug 2016 21:20:51 -0400
Subject: Re: [PATCH v8 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
References: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
 <1471377024-2244-5-git-send-email-cmetcalf@mellanox.com>
 <20160818151211.GN13300@pathway.suse.cz>
From: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <aa556fe4-901c-196b-d3a1-ab92a701cbaa@mellanox.com>
Date: Mon, 29 Aug 2016 11:46:52 -0400
MIME-Version: 1.0
In-Reply-To: <20160818151211.GN13300@pathway.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160829154652.aq23euyV_C875KzzLbUYSk7fBT6UTTj-ABC_MhXNqIw@z>

On 8/18/2016 11:12 AM, Petr Mladek wrote:
> On Tue 2016-08-16 15:50:24, Chris Metcalf wrote:
>> [...]
>> -static inline void native_safe_halt(void)
>> +static __always_inline void native_safe_halt(void)
>>   {
>>   	asm volatile("sti; hlt": : :"memory");
>>   }
> Ah, the __always_inline stuff did not helped here. It was
> not inlined:
>
> $> nm -n vmlinux | grep native_safe_halt
> ffffffff81050bc0 t native_safe_halt
>
> The reason seems to be that it is called via
> PVOP_VCALL0(pv_irq_ops.safe_halt);, see below
> in the disassembly.
>
> I guess that it is because I have
> CONFIG_PARAVIRT=y

I fixed this by reverting to using __cpuidle instead of __always_inline.
As you discovered, we can't use <linux/cpu.h> here, but I chose to
just duplicate the #define of __cpuidle in <asm/irqflags.h> instead
since I think that's cleaner.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

