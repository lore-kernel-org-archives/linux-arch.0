From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: RISC-V Linux Port v2
Date: Tue,  6 Jun 2017 15:59:50 -0700
Message-ID: <20170606230007.19101-1-palmer__44437.3938291848$1496790097$gmane$org@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523004107.536-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org

Thanks to everyone who has participated in the review process so far.  We've
made a lot of changes since the v1 and while this isn't ready to go yet, I
finally managed to get through everything in my inbox so I thought it would be
a good time to submit a v2 so everyone is on the same page.

A highlight of the changes since the v1 patch set includes:

  * We've split out our drivers into the right places, which means now there's
    a lot more patches.  I'll be submitting these patches to various subsystem
    maintainers and including them in any future RISC-V patch sets until
    they've been merged.

  * The SBI console driver has been completely rewritten to use the HVC helpers
    and is now significantly smaller.

  * We've begun to use weaker barries as opposed to just the big "fence".
    There's still some work to do here, specifically:
    - We need fences in the realxed MMIO functions.
    - The non-relaxed MMIO functions are missing R/W bits on their fences.
    - Many AMOs need the aq and rl bits set.

  * We now have thread_info in task_struct.  As a result, sscratch now contains
    TP instead of SP.  This was necessary because thread_info is no longer on
    the stack.

  * A few shared routines have been added that we use instead of creating
    another arch copy.

Here's my TODO list

  * The memory model changes indicated above.

  * I need to go through checkpatch again to make sure none of the messages are
    valid problems.

  * Put an implementation of atomic compare/exchange in the VDSO when atomic
    instructions are enabled, otherwise insert stubs to the cmpxchg syscall.

  * Remove the extra multiplexing in the cmpxchg syscall.

Aside from those two releatively minor ABI issues, I think our ABI is in good
shape.  Unless there are any other issues that crop up I'd like to begin our
glibc submission early next week.

[PATCH 01/17] drivers: support PCIe in RISCV
[PATCH 02/17] pcie-xilinx: add missing 5th legacy interrupt
[PATCH 03/17] base: fix order of OF initialization
[PATCH 04/17] Documentation: atomic_ops.txt is
[PATCH 05/17] MAINTAINERS: Add RISC-V
[PATCH 06/17] pci: Add generic pcibios_{fixup_bus,align_resource}
[PATCH 07/17] lib: Add shared copies of some GCC library routines
[PATCH 08/17] dts: include documentation for the RISC-V interrupt
[PATCH 09/17] clocksource/timer-riscv: New RISC-V Clocksource
[PATCH 10/17] irqchip: New RISC-V PLIC Driver
[PATCH 11/17] irqchip: RISC-V Local Interrupt Controller Driver
[PATCH 12/17] tty: New RISC-V SBI Console Driver
[PATCH 13/17] RISC-V: Add include subdirectory
[PATCH 14/17] RISC-V: lib files
[PATCH 15/17] RISC-V: Add mm subdirectory
[PATCH 16/17] RISC-V: Add kernel subdirectory
[PATCH 17/17] RISC-V: Makefile and Kconfig
