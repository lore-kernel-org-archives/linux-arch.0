From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 21 Mar 2016 13:12:39 -0400
Message-ID: <56F02B87.2000307@mellanox.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
 <20160321154201.GA6344@twins.programming.kicks-ass.net>
 <56F01E10.6030909@mellanox.com>
 <20160321163215.GC6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160321163215.GC6344@twins.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Aaron Tomlin <atomlin@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 03/21/2016 12:32 PM, Peter Zijlstra wrote:
> On Mon, Mar 21, 2016 at 12:15:12PM -0400, Chris Metcalf wrote:
>> On 03/21/2016 11:42 AM, Peter Zijlstra wrote:
>>> The most common idle function for x86 is: mwait_idle_with_hints(),
>>> trouble is, its an inline, so I'm not sure adding __cpuidle to it does
>>> anything.
>> No, you're right, it wouldn't help.  I didn't look at the drivers/cpuidle
>> subsystem at all in my patch, since I'm not that familiar with it,
>> but it seems like tagging acpi_processor_ffh_cstate_enter(), as the
>> only user of mwait_idle_with_hints(), will do the job.
> intel_idle() also uses it.

Ah, of course.  I was only looking at the config options enabled in the
kernel I was building.  I've added INTEL_IDLE now and grep'ed the whole
kernel tree as well, finding a couple of extra possibilities:

I do see mwait used in the ACPI 4.0 Processor Aggregator Device driver, but
this seems sufficiently far removed from regular cpuidle that I don't
think it's appropriate to tag the power_saving_thread() function -
the initial commit talks about using the mechanism "to ride-out
transient electrical and thermal emergencies."

There's also the thermal "powerclamp" driver that enforces a particular
amount of idle time across the system.  For this one it's less clear to
me whether this is a valid "idle" state that we should ignore when doing
NMI backtracing.  This would be the clamp_thread() function in
drivers/thermal/intel_powerclamp.c.  For now I'm not including it,
but what do you think?

> # nm -n ivb-ep-build/vmlinux | awk '/__cpuidle_text_start/ {p=1} {if (p) print $0} /__cpuidle_text_end/ {p=0}'
> ffffffff81b16ca8 T __cpuidle_text_start
> ffffffff81b16cb0 T default_idle
> ffffffff81b16e50 t mwait_idle
> ffffffff81b17080 t cpu_idle_poll
> ffffffff81b17280 T default_idle_call
> ffffffff81b172be T __cpuidle_text_end
>
> So no intel_idle for me..

With the changes discussed so far in this email thread, we've gotten to:

ffffffff818df178 T __cpuidle_text_start
ffffffff818df180 T default_idle
ffffffff818df260 t mwait_idle
ffffffff818df3f0 T acpi_processor_ffh_cstate_enter
ffffffff818df4a0 T default_idle_call
ffffffff818df4e0 t cpu_idle_poll
ffffffff818df600 t intel_idle_freeze
ffffffff818df6a0 t intel_idle
ffffffff818df7b5 T __cpuidle_text_end

This is about 1,600 bytes (or about 450 instructions) that will cause
NMI to skip doing a backtrace if the PC is anywhere in the range.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
