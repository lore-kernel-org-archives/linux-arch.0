From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH v7 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Tue, 9 Aug 2016 09:25:27 -0400
Message-ID: <c615a222-a20a-4cbc-f045-4c7c45baa632@mellanox.com>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
 <1470672218-16059-5-git-send-email-cmetcalf@mellanox.com>
 <20160808164828.GH12649@leverpostej> <20160809103708.GC23769@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160809103708.GC23769@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@osdl.org>, Petr Mladek <pmladek@suse.com>, Daniel Thompson <daniel.thompson@linaro.org>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Aaron Tomlin <atomlin@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 8/9/2016 6:37 AM, Lorenzo Pieralisi wrote:
> On Mon, Aug 08, 2016 at 05:48:28PM +0100, Mark Rutland wrote:
>> Hi,
>>
>> [adding Lorenzo]
>>
>> On Mon, Aug 08, 2016 at 12:03:38PM -0400, Chris Metcalf wrote:
>>> When doing an nmi backtrace of many cores, most of which are idle,
>>> the output is a little overwhelming and very uninformative.  Suppress
>>> messages for cpus that are idling when they are interrupted and just
>>> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
>>>
>>> We do this by grouping all the cpuidle code together into a new
>>> .cpuidle.text section, and then checking the address of the
>>> interrupted PC to see if it lies within that section.
>>>
>>> This commit suitably tags x86, arm64, and tile idle routines,
>>> and only adds in the minimal framework for other architectures.
>>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>>> index 659963d40bb4..fe7f93b7b11b 100644
>>> --- a/arch/arm64/kernel/vmlinux.lds.S
>>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>>> @@ -122,6 +122,7 @@ SECTIONS
>>>   			ENTRY_TEXT
>>>   			TEXT_TEXT
>>>   			SCHED_TEXT
>>> +			CPUIDLE_TEXT
>>>   			LOCK_TEXT
>>>   			KPROBES_TEXT
>>>   			HYPERVISOR_TEXT
>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>>> index 5bb61de23201..64f088ca3192 100644
>>> --- a/arch/arm64/mm/proc.S
>>> +++ b/arch/arm64/mm/proc.S
>>> @@ -48,11 +48,13 @@
>>>    *
>>>    *	Idle the processor (wait for interrupt).
>>>    */
>>> +	.pushsection ".cpuidle.text","ax"
>>>   ENTRY(cpu_do_idle)
>>>   	dsb	sy				// WFI may enter a low-power mode
>>>   	wfi
>>>   	ret
>>>   ENDPROC(cpu_do_idle)
>>> +	.popsection
>>  From a quick scan it looks like we only call this with interrupts
>> disabled, and we have no NMI. So shouldn't we be annotating
>> arch_cpu_idle(), which calls this and subsequently enables interrupts?

You're right - I made a quick mental mapping between the arch/tile
_cpu_idle assembly and the arch/arm64 cpu_do_idle.  But on tile the
way it works is we can racelessly enable interrupts and then issue the
"nap" instruction; it is similar to WFI except that you actually take
the interrupt right from the nap instruction itself, and then have to
manually bump forward the PC in the handler if you want the nap to act
more like a WFI.  I see on closer examination that you're right, we
won't interrupt in the cpu_do_idle assembly anyway.

You're also right that there is no support for remote stack dump on
arm64 right now.  I added the arm64 "support" just because I am
hacking on arm64 most of the day at this point anyway, and felt like
the cpu_idle tracking knowledge might as well be there if/when support
for some kind of NMI-style remote interrupt was added to the Linux
implementation.

The Tile architecture also has no "NMI" per se, but we use individual
bitmasks to enable and disable interrupts, so the Linux irq_disable()
just amounts to "write a particular bitmask into the enable
register".  The bitmask itself is just a per-cpu variable that changes
as interrupt sources are configured, and there are a few (a couple of
performance interrupts, and a synthetic one used for cross-core ipi)
that we never mark as maskable.

>> I'm also not sure what you need to do for PSCI, which is the preferred
>> (FW-backed) idle mechanism for arm64. The infrastrucure for that is
>> spread over a few files:
>>
>>    arch/arm64/kernel/sleep.S
>>    arch/arm64/kernel/smccc-call.S
>>    arch/arm64/kernel/suspend.c
>>    drivers/cpuidle/cpuidle-arm.c
>>    drivers/firmware/psci.c
>>
>> I'm not sure where we'd be an an interruptible state, and therefore I'm
>> not immediately sure what we should annotate.
> I am probably missing something here, but let me add that I am not
> sure I understand how this patch can be used on ARM/ARM64 systems
> so ARM platform idle back-end code annotation is basically useless
> given that it is code that can't be preempted anyway (and even if
> it could PC range check can even fail given that we may execute some
> code with MMU off so out of physical addresses).

I think this is all fair enough, and I will back out the arm64 "support" for my next
patch series.

> What's the purpose of this cpu idle tracking ? Can't it be implemented
> in a simpler way (ie RCU API) ?

The cpu idle tracking here is done solely to make the "backtrace all cpus" output
less crazy-verbose.  We annotate functions because claiming "there's nothing
interesting to see here; go away" is not something you want to do unless you're
really quite sure that there's nothing interesting going on there. In particular, if
the RCU stuff is screwed up, you want to see backtraces out of the RCU code if you
happen to be somehow stuck there, even if some RCU state claims you are idle.

See e.g. the discussion with Peter Ziljstra starting around here:

https://lkml.org/lkml/2016/3/7/681

Thanks!

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
