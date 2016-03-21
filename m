From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 21 Mar 2016 12:15:12 -0400
Message-ID: <56F01E10.6030909@mellanox.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
 <20160321154201.GA6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160321154201.GA6344@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 03/21/2016 11:42 AM, Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 01:02:13PM -0400, Chris Metcalf wrote:
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index 9f7c21c22477..d569ae7fde37 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -298,7 +298,7 @@ void arch_cpu_idle(void)
>>   /*
>>    * We use this if we don't have any better idle routine..
>>    */
>> -void default_idle(void)
>> +void __cpuidle default_idle(void)
>>   {
>>   	trace_cpu_idle_rcuidle(1, smp_processor_id());
>>   	safe_halt();
>> @@ -413,7 +413,7 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>>    * with interrupts enabled and no flags, which is backwards compatible with the
>>    * original MWAIT implementation.
>>    */
>> -static void mwait_idle(void)
>> +static __cpuidle void mwait_idle(void)
>>   {
>>   	if (!current_set_polling_and_test()) {
>>   		trace_cpu_idle_rcuidle(1, smp_processor_id());
> The most common idle function for x86 is: mwait_idle_with_hints(),
> trouble is, its an inline, so I'm not sure adding __cpuidle to it does
> anything.

No, you're right, it wouldn't help.  I didn't look at the drivers/cpuidle
subsystem at all in my patch, since I'm not that familiar with it,
but it seems like tagging acpi_processor_ffh_cstate_enter(), as the
only user of mwait_idle_with_hints(), will do the job.

I do see that native_play_dead() also uses mwait/monitor, but since
that's hotplug I don't think it's relevant to this patch series.

> I've yet to find the magic objdump incantation to check. Or rather
> objdump -h doesn't appear to list .cpuidle.text at all :/
>
> I'm probably doing something silly...

The easiest way to check for a given function is just to look
at the "nm -n" output and see that all the functions you expect
to reflect idle behavior are in the cpuidle begin/end range.
Or, to look at "objdump -dr" and search for monitor/mwait.

objdump -h certainly works to show .cpuidle.text if you look at
individual objects (e.g. arch/x86/kernel/process.o) but by the time
you're looking at the linked vmlinux image they have all been linked
into the giant .text section.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
