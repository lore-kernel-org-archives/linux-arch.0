From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2] arm64: compat: Reduce address limit
Date: Tue, 02 Apr 2019 15:48:28 +0000
Message-ID: <20190402154829.506C020882@mail.kernel.org>
References: <20190401113014.20866-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401113014.20866-1-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sasha Levin <sashal@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org, Jann Horn <jannh@google.com>
List-Id: linux-arch.vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.0.5, v4.19.32, v4.14.109, v4.9.166, v4.4.177, v3.18.137.

v5.0.5: Build OK!
v4.19.32: Build OK!
v4.14.109: Build OK!
v4.9.166: Build OK!
v4.4.177: Failed to apply! Possible dependencies:
    132cd887b5c5 ("arm64: Modify stack trace and dump for use with irq_stack")
    39bc88e5e38e ("arm64: Disable TTBR0_EL1 during normal kernel execution")
    4dffbfc48d65 ("arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP")
    57f4959bad0a ("arm64: kernel: Add support for User Access Override")
    705441960033 ("arm64: kernel: Don't toggle PAN on systems with UAO")
    7dd01aef0557 ("arm64: trap userspace "dc cvau" cache operation on errata-affected core")
    87261d19046a ("arm64: Cortex-A53 errata workaround: check for kernel addresses")
    8e23dacd12a4 ("arm64: Add do_softirq_own_stack() and enable irq_stacks")
    9e8e865bbe29 ("arm64: unify idmap removal")
    bffe1baff5d5 ("arm64: kasan: instrument user memory access API")
    d5370f754875 ("arm64: prefetch: add alternative pattern for CPUs without a prefetcher")
    e5bc22a42e4d ("arm64/efi: split off EFI init and runtime code for reuse by 32-bit ARM")
    e7227d0e528f ("arm64: Cleanup SCTLR flags")
    eef94a3d09aa ("arm64: move TASK_* definitions to <asm/processor.h>")
    f7d924894265 ("arm64/efi: refactor EFI init and runtime code for reuse by 32-bit ARM")

v3.18.137: Failed to apply! Possible dependencies:
    04597a65c5ef ("arm64: Track system support for mixed endian EL0")
    127db024a7ba ("arm64: introduce VA_START macro - the first kernel virtual address.")
    1b907f46db07 ("arm64: kconfig: move emulation option under kernel features")
    2d888f48e056 ("arm64: Emulate SETEND for AArch32 tasks")
    338d4f49d6f7 ("arm64: kernel: Add support for Privileged Access Never")
    359b706473b4 ("arm64: Extract feature parsing code from cpu_errata.c")
    587064b610c7 ("arm64: Add framework for legacy instruction emulation")
    736d474f0faf ("arm64: Consolidate hotplug notifier for instruction emulation")
    870828e57b14 ("arm64: kernel: Move config_sctlr_el1")
    94a9e04aa16a ("arm64: alternative: Introduce feature for GICv3 CPU interface")
    9b79f52d1a70 ("arm64: Add support for hooks to handle undefined instructions")
    aa03c428e678 ("arm64: Fix overlapping VA allocations")
    bd35a4adc413 ("arm64: Port SWP/SWPB emulation support from arm")
    c852f3205846 ("arm64: Emulate CP15 Barrier instructions")
    c9453a3ab1a3 ("arm64: alternatives: fix pr_fmt string for consistency")
    c9465b4ec37a ("arm64: add support to dump the kernel page tables")
    eef94a3d09aa ("arm64: move TASK_* definitions to <asm/processor.h>")


How should we proceed with this patch?

--
Thanks,
Sasha
