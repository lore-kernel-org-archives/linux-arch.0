From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH v5 0/4] improvements to the nmi_backtrace code
Date: Wed, 13 Jul 2016 14:44:17 -0400
Message-ID: <96e5ba5b-d8c2-42cd-11a3-ffebd85522c3@mellanox.com>
References: <1459877208-15119-1-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1459877208-15119-1-git-send-email-cmetcalf@mellanox.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Petr Mladek <pmladek@suse.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Ping!

I just realized that this series [1] hasn't been taken into an upstream tree yet.
It probably makes most sense to go via Andrew's tree, given that that's
where Petr's NMI printk cleanup patches went a couple of months ago, for 4.7.
It seemed like this patch series had reached consensus in its current form.

Andrew, if I rebase this on 4.7, do you want to take it into your tree?
Your concern before was just that it conflicted with Petr's work [2].

Thanks!

[1] http://lkml.kernel.org/g/1459877208-15119-1-git-send-email-cmetcalf@mellanox.com
[2] http://lkml.kernel.org/g/20160229164956.8613016895bef966b6460081@linux-foundation.org

On 4/5/2016 1:26 PM, Chris Metcalf wrote:
> This is just a one-line change to the v4 series, to catch the new arm
> vmlinux-xip.lds.S file, which I missed when I rebased to 4.6 for v4
> (my arm config for testing did not include CONFIG_XIP_KERNEL).
> Thanks to Fengguang Wu and the 0-day test robot for that.
>
> Whose tree would this go through?  I have an ack for Peter Z for
> patch 4/4 and no other feedback for patches 1/4 or 2/4; I can
> certainly push 3/4 through the tile tree myself if that helps, though
> my guess is keeping it with the rest of the series makes more sense
> for tile since it doesn't lose any functionality that way.
>
>  From the version 1 cover letter:
>
>    This patch series modifies the trigger_xxx_backtrace() NMI-based
>    remote backtracing code to make it more flexible, and makes a few
>    small improvements along the way.
>
>    The motivation comes from the task isolation code, where there are
>    scenarios where we want to be able to diagnose a case where some cpu
>    is about to interrupt a task-isolated cpu.  It can be helpful to
>    see both where the interrupting cpu is, and also an approximation
>    of where the cpu that is being interrupted is.  The nmi_backtrace
>    framework allows us to discover the stack of the interrupted cpu.
>
> I've tested that the change works as desired on tile, and build-tested
> x86, arm64, and arm.  For x86 and arm64 I confirmed that the generic
> cpuidle stuff as well as the architecture-specific routines are in the
> new cpuidle section.  For arm I just build-tested it and made sure the
> generic cpuidle routines were in the new cpuidle section, but I didn't
> attempt to tease apart the tangle of platform-specific idle routines
> that arm has and tag them with __cpuidle.  That might be more usefully
> done by someone with arm platform experience in a follow-up patch.
>
> I have also pushed it up to kernel.org to pull if that's easier:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile.git nmi-backtrace
>
> The change conflicts with Petr Mladek's NMI printk cleanup patches:
>
> https://lkml.kernel.org/r/1459353210-20260-1-git-send-email-pmladek@suse.com
>
> He has kindly offered to resolve the conflicts.
>
> v5: Add CPUIDLE_TEXT to the new arch/arm/kernel/vmlinux-xip.lds.S
>
> v4: Added some more __cpuidle functions (PeterZ, Rafael Wysocki)
>      Rebased to kernel v4.6-rc1
>
> v3: Various improvements to the set of __cpuidle functions;
>      Add back in a missing section accidentally removed in modpost.c (PeterZ)
>      https://lkml.kernel.org/r/1458667179-19630-1-git-send-email-cmetcalf@mellanox.com
>
> v2: Switch to using __cpuidle tagging, switch S-O-B to Mellanox
>      https://lkml.kernel.org/r/1458147733-29338-1-git-send-email-cmetcalf@mellanox.com
>
> Chris Metcalf (4):
>    nmi_backtrace: add more trigger_*_cpu_backtrace() methods
>    nmi_backtrace: do a local dump_stack() instead of a self-NMI
>    arch/tile: adopt the new nmi_backtrace framework
>    nmi_backtrace: generate one-line reports for idle cpus
>
>   arch/alpha/kernel/vmlinux.lds.S      |  1 +
>   arch/arc/kernel/vmlinux.lds.S        |  1 +
>   arch/arm/include/asm/irq.h           |  4 +-
>   arch/arm/kernel/smp.c                | 13 +------
>   arch/arm/kernel/vmlinux-xip.lds.S    |  1 +
>   arch/arm/kernel/vmlinux.lds.S        |  1 +
>   arch/arm64/kernel/vmlinux.lds.S      |  1 +
>   arch/arm64/mm/proc.S                 |  2 +
>   arch/avr32/kernel/vmlinux.lds.S      |  1 +
>   arch/blackfin/kernel/vmlinux.lds.S   |  1 +
>   arch/c6x/kernel/vmlinux.lds.S        |  1 +
>   arch/cris/kernel/vmlinux.lds.S       |  1 +
>   arch/frv/kernel/vmlinux.lds.S        |  1 +
>   arch/h8300/kernel/vmlinux.lds.S      |  1 +
>   arch/hexagon/kernel/vmlinux.lds.S    |  1 +
>   arch/ia64/kernel/vmlinux.lds.S       |  1 +
>   arch/m32r/kernel/vmlinux.lds.S       |  1 +
>   arch/m68k/kernel/vmlinux-nommu.lds   |  1 +
>   arch/m68k/kernel/vmlinux-std.lds     |  1 +
>   arch/m68k/kernel/vmlinux-sun3.lds    |  1 +
>   arch/metag/kernel/vmlinux.lds.S      |  1 +
>   arch/microblaze/kernel/vmlinux.lds.S |  1 +
>   arch/mips/kernel/vmlinux.lds.S       |  1 +
>   arch/mn10300/kernel/vmlinux.lds.S    |  1 +
>   arch/nios2/kernel/vmlinux.lds.S      |  1 +
>   arch/openrisc/kernel/vmlinux.lds.S   |  1 +
>   arch/parisc/kernel/vmlinux.lds.S     |  1 +
>   arch/powerpc/kernel/vmlinux.lds.S    |  1 +
>   arch/s390/kernel/vmlinux.lds.S       |  1 +
>   arch/score/kernel/vmlinux.lds.S      |  1 +
>   arch/sh/kernel/vmlinux.lds.S         |  1 +
>   arch/sparc/kernel/vmlinux.lds.S      |  1 +
>   arch/tile/include/asm/irq.h          |  4 +-
>   arch/tile/kernel/entry.S             |  2 +-
>   arch/tile/kernel/pmc.c               |  3 --
>   arch/tile/kernel/process.c           | 72 ++++++++----------------------------
>   arch/tile/kernel/traps.c             |  7 +++-
>   arch/tile/kernel/vmlinux.lds.S       |  1 +
>   arch/um/kernel/dyn.lds.S             |  1 +
>   arch/um/kernel/uml.lds.S             |  1 +
>   arch/unicore32/kernel/vmlinux.lds.S  |  1 +
>   arch/x86/include/asm/irq.h           |  4 +-
>   arch/x86/kernel/acpi/cstate.c        |  2 +-
>   arch/x86/kernel/apic/hw_nmi.c        |  6 +--
>   arch/x86/kernel/process.c            |  4 +-
>   arch/x86/kernel/vmlinux.lds.S        |  1 +
>   arch/xtensa/kernel/vmlinux.lds.S     |  3 ++
>   drivers/acpi/processor_idle.c        |  5 ++-
>   drivers/cpuidle/driver.c             |  5 ++-
>   drivers/idle/intel_idle.c            |  4 +-
>   include/asm-generic/vmlinux.lds.h    |  6 +++
>   include/linux/cpu.h                  |  5 +++
>   include/linux/nmi.h                  | 63 ++++++++++++++++++++++++-------
>   kernel/sched/idle.c                  | 13 ++++++-
>   lib/nmi_backtrace.c                  | 40 +++++++++++++-------
>   scripts/mod/modpost.c                |  2 +-
>   scripts/recordmcount.c               |  1 +
>   scripts/recordmcount.pl              |  1 +
>   58 files changed, 184 insertions(+), 121 deletions(-)
>

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
