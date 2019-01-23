From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v9 01/26] arm64: Fix HCR.TGE status for NMI contexts
Date: Wed, 23 Jan 2019 22:57:42 +0000
Message-ID: <20190123225743.B814420856@mail.kernel.org>
References: <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sasha Levin <sashal@kernel.org>, Julien Thierry <julien.thierry@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, daniel.thompson@linaro.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, James Morse <james.morse@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v4.20.3, v4.19.16, v4.14.94, v4.9.151, v4.4.171, v3.18.132.

v4.20.3: Build OK!
v4.19.16: Build OK!
v4.14.94: Build OK!
v4.9.151: Failed to apply! Possible dependencies:
    096683724cb2 ("arm64: unwind: avoid percpu indirection for irq stack")
    34be98f4944f ("arm64: kernel: remove {THREAD,IRQ_STACK}_START_SP")
    a9ea0017ebe8 ("arm64: factor out current_stack_pointer")
    c02433dd6de3 ("arm64: split thread_info from task stack")
    c7365330753c ("arm64: unwind: disregard frame.sp when validating frame pointer")
    dbc9344a68e5 ("arm64: clean up THREAD_* definitions")
    f60ad4edcf07 ("arm64: clean up irq stack definitions")
    f60fe78f1332 ("arm64: use an irq stack pointer")

v4.4.171: Failed to apply! Possible dependencies:
    096683724cb2 ("arm64: unwind: avoid percpu indirection for irq stack")
    0a8ea52c3eb1 ("arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature")
    132cd887b5c5 ("arm64: Modify stack trace and dump for use with irq_stack")
    1ffe199b1c9b ("arm64: when walking onto the task stack, check sp & fp are in current->stack")
    20380bb390a4 ("arm64: ftrace: fix a stack tracer's output under function graph tracer")
    7596abf2e566 ("arm64: irq: fix walking from irq stack to task stack")
    8e23dacd12a4 ("arm64: Add do_softirq_own_stack() and enable irq_stacks")
    971c67ce37cf ("arm64: reduce stack use in irq_handler")
    a80a0eb70c35 ("arm64: make irq_stack_ptr more robust")
    c7365330753c ("arm64: unwind: disregard frame.sp when validating frame pointer")
    f60ad4edcf07 ("arm64: clean up irq stack definitions")
    f60fe78f1332 ("arm64: use an irq stack pointer")
    fe13f95b7200 ("arm64: pass a task parameter to unwind_frame()")

v3.18.132: Failed to apply! Possible dependencies:
    020295b4cb5b ("ACPI / processor: Make it possible to get CPU hardware ID via GICC")
    132cd887b5c5 ("arm64: Modify stack trace and dump for use with irq_stack")
    13ca62b243f6 ("ACPI: Fix minor syntax issues in processor_core.c")
    37655163ce1a ("ARM64 / ACPI: Get RSDP and ACPI boot-time tables")
    587064b610c7 ("arm64: Add framework for legacy instruction emulation")
    652261a7a86c ("ACPI: fix acpi_os_ioremap for arm64")
    828aef376d7a ("ACPI / processor: Introduce phys_cpuid_t for CPU hardware ID")
    96f0e00378d4 ("ARM: add basic support for on-demand backtrace of other CPUs")
    af2c632e234f ("arm64/include/asm: Fixed a warning about 'struct pt_regs'")
    af8f3f514d19 ("ACPI / processor: Convert apic_id to phys_id to make it arch agnostic")
    b4ff8389ed14 ("xen/events: Always allocate legacy interrupts on PV guests")
    d02dc27db0dc ("ACPI / processor: Rename acpi_(un)map_lsapic() to acpi_(un)map_cpu()")
    d60fc3892c4d ("irqchip: Add GICv2 specific ACPI boot support")
    ecf5636dcd59 ("ACPI: Add interfaces to parse IOAPIC ID for IOAPIC hotplug")
    f60ad4edcf07 ("arm64: clean up irq stack definitions")
    f60fe78f1332 ("arm64: use an irq stack pointer")


How should we proceed with this patch?

--
Thanks,
Sasha
