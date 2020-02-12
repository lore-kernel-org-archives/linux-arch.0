Return-Path: <monstr@monstr.eu>
Sender: Michal Simek <monstr@monstr.eu>
From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 00/10] Hi,
Date: Wed, 12 Feb 2020 09:57:57 +0100
Message-ID: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Borislav Petkov <bp@suse.de>, Cornelia Huck <cohuck@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greg Ungerer <gerg@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mike Rapoport <rppt@linux.ibm.com>, Mubin Sayyed <mubinusm@xilinx.com>, Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>, Stefan Asserhall <stefan.asserhall@xilinx.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200212085757.gvwaW4EDUWlCxY2LMEJXnVDjvNRXccdKkLbWznwy7lU@z>


I am sending this series as before SMP support.
Most of these patches are clean ups and should be easy to review them. I
expect there will be more discussions about SMP support.

There could be some optimization added based on
https://lkml.org/lkml/2020/2/10/1528

Thanks,
Michal


Michal Simek (6):
  microblaze: Convert headers to SPDX license
  microblaze: Remove architecture tlb.h and use generic one
  microblaze: Remove early printk setup
  microblaze: Remove empty headers
  microblaze: Remove unused boot_cpuid variable
  microblaze: Use asm generic cmpxchg.h for !SMP case

Stefan Asserhall (4):
  microblaze: Define microblaze barrier
  microblaze: Add sync to tlb operations
  microblaze: Add missing irqflags.h header
  microblaze: Define percpu sestion in linker file

 arch/microblaze/include/asm/Kbuild            |  4 +-
 arch/microblaze/include/asm/barrier.h         | 13 ++++++
 arch/microblaze/include/asm/cache.h           |  5 +--
 arch/microblaze/include/asm/cacheflush.h      |  6 +--
 arch/microblaze/include/asm/checksum.h        |  5 +--
 arch/microblaze/include/asm/cmpxchg.h         | 40 ++-----------------
 arch/microblaze/include/asm/cpuinfo.h         |  5 +--
 arch/microblaze/include/asm/cputable.h        |  1 -
 arch/microblaze/include/asm/current.h         |  5 +--
 arch/microblaze/include/asm/delay.h           |  7 +---
 arch/microblaze/include/asm/dma.h             |  5 +--
 arch/microblaze/include/asm/elf.h             |  5 +--
 arch/microblaze/include/asm/entry.h           |  5 +--
 arch/microblaze/include/asm/exceptions.h      |  5 +--
 arch/microblaze/include/asm/fixmap.h          |  5 +--
 arch/microblaze/include/asm/flat.h            |  5 +--
 arch/microblaze/include/asm/hw_irq.h          |  1 -
 arch/microblaze/include/asm/io.h              |  5 +--
 arch/microblaze/include/asm/irq.h             |  5 +--
 arch/microblaze/include/asm/irqflags.h        |  5 +--
 arch/microblaze/include/asm/mmu.h             |  5 +--
 arch/microblaze/include/asm/mmu_context_mm.h  |  5 +--
 arch/microblaze/include/asm/module.h          |  5 +--
 arch/microblaze/include/asm/page.h            |  5 +--
 arch/microblaze/include/asm/pgalloc.h         |  5 +--
 arch/microblaze/include/asm/pgtable.h         |  5 +--
 arch/microblaze/include/asm/processor.h       |  5 +--
 arch/microblaze/include/asm/ptrace.h          |  5 +--
 arch/microblaze/include/asm/pvr.h             |  5 +--
 arch/microblaze/include/asm/registers.h       |  5 +--
 arch/microblaze/include/asm/sections.h        |  5 +--
 arch/microblaze/include/asm/setup.h           |  7 +---
 arch/microblaze/include/asm/string.h          |  5 +--
 arch/microblaze/include/asm/switch_to.h       |  5 +--
 arch/microblaze/include/asm/thread_info.h     |  5 +--
 arch/microblaze/include/asm/timex.h           |  5 +--
 arch/microblaze/include/asm/tlb.h             | 17 --------
 arch/microblaze/include/asm/tlbflush.h        |  5 +--
 arch/microblaze/include/asm/uaccess.h         |  5 +--
 arch/microblaze/include/asm/unaligned.h       |  5 +--
 arch/microblaze/include/asm/unistd.h          |  5 +--
 arch/microblaze/include/asm/unwind.h          |  5 +--
 arch/microblaze/include/asm/user.h            |  1 -
 arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c |  7 +---
 arch/microblaze/kernel/cpu/pvr.c              |  1 +
 arch/microblaze/kernel/misc.S                 |  3 +-
 arch/microblaze/kernel/setup.c                |  1 -
 arch/microblaze/kernel/vmlinux.lds.S          |  3 ++
 48 files changed, 62 insertions(+), 215 deletions(-)
 create mode 100644 arch/microblaze/include/asm/barrier.h
 delete mode 100644 arch/microblaze/include/asm/cputable.h
 delete mode 100644 arch/microblaze/include/asm/hw_irq.h
 delete mode 100644 arch/microblaze/include/asm/tlb.h
 delete mode 100644 arch/microblaze/include/asm/user.h

-- 
2.25.0
