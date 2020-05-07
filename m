From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 02/14] arm: add support for folded p4d page tables
Date: Thu, 7 May 2020 14:16:56 +0200
Message-ID: <39ba8a04-d6b5-649d-c289-0c8b27cb66c5@samsung.com>
References: <20200414153455.21744-1-rppt@kernel.org>
        <20200414153455.21744-3-rppt@kernel.org>
        <CGME20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38686 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgEGMRB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2020 08:17:01 -0400
In-Reply-To: <20200414153455.21744-3-rppt@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>, linux-arch@vger.kernel.org, Brian Cain <bcain@codeaurora.org>, Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Mike Rapoport <rppt@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, kvm-ppc@vger.kernel.org, Stefan Kristiansson <stefa>

Hi

On 14.04.2020 17:34, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate, and remove __ARCH_USE_5LEVEL_HACK.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Today I've noticed that kexec is broken on ARM 32bit. Bisecting between 
current linux-next and v5.7-rc1 pointed to this commit. I've tested this 
on Odroid XU4 and Raspberry Pi4 boards. Here is the relevant log:

# kexec --kexec-syscall -l zImage --append "$(cat /proc/cmdline)"
memory_range[0]:0x40000000..0xbe9fffff
memory_range[0]:0x40000000..0xbe9fffff
# kexec -e
kexec_core: Starting new kernel
8<--- cut here ---
Unable to handle kernel paging request at virtual address c010f1f4
pgd = c6817793
[c010f1f4] *pgd=4000041e(bad)
Internal error: Oops: 80d [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1329 Comm: kexec Tainted: G        W 
5.7.0-rc3-00127-g6cba81ed0f62 #611
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at machine_kexec+0x40/0xfc
LR is at 0xffffffff
pc : [<c010f0b4>]    lr : [<ffffffff>]    psr: 60000013
sp : ebc13e60  ip : 40008000  fp : 00000001
r10: 00000058  r9 : fee1dead  r8 : 00000001
r7 : c121387c  r6 : 6c224000  r5 : ece40c00  r4 : ec222000
r3 : c010f1f4  r2 : c1100000  r1 : c1100000  r0 : 418d0000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6bc14059  DAC: 00000051
Process kexec (pid: 1329, stack limit = 0x366bb4dc)
Stack: (0xebc13e60 to 0xebc14000)
...
[<c010f0b4>] (machine_kexec) from [<c01c0d84>] (kernel_kexec+0x74/0x7c)
[<c01c0d84>] (kernel_kexec) from [<c014b1bc>] (__do_sys_reboot+0x1f8/0x210)
[<c014b1bc>] (__do_sys_reboot) from [<c0100060>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xebc13fa8 to 0xebc13ff0)
...
---[ end trace 3e8d6c81723c778d ]---
1329 Segmentation fault      ./kexec -e

> ---
>   arch/arm/include/asm/pgtable.h     |  1 -
>   arch/arm/lib/uaccess_with_memcpy.c |  7 +++++-
>   arch/arm/mach-sa1100/assabet.c     |  2 +-
>   arch/arm/mm/dump.c                 | 29 +++++++++++++++++-----
>   arch/arm/mm/fault-armv.c           |  7 +++++-
>   arch/arm/mm/fault.c                | 22 ++++++++++------
>   arch/arm/mm/idmap.c                |  3 ++-
>   arch/arm/mm/init.c                 |  2 +-
>   arch/arm/mm/ioremap.c              | 12 ++++++---
>   arch/arm/mm/mm.h                   |  2 +-
>   arch/arm/mm/mmu.c                  | 35 +++++++++++++++++++++-----
>   arch/arm/mm/pgd.c                  | 40 ++++++++++++++++++++++++------
>   12 files changed, 125 insertions(+), 37 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
