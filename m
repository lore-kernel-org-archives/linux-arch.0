From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH v8 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 29 Aug 2016 11:46:52 -0400
Message-ID: <aa556fe4-901c-196b-d3a1-ab92a701cbaa@mellanox.com>
References: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
 <1471377024-2244-5-git-send-email-cmetcalf@mellanox.com>
 <20160818151211.GN13300@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160818151211.GN13300@pathway.suse.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Aaron Tomlin <atomlin@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
