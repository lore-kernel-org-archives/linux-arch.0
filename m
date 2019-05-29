From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v4 1/3] powerpc: Fix vDSO clock_getres()
Date: Wed, 29 May 2019 13:14:56 +0000
Message-ID: <20190529131456.F00B7217F9@mail.kernel.org>
References: <20190523112116.19233-2-vincenzo.frascino@arm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190523112116.19233-2-vincenzo.frascino@arm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Sasha Levin <sashal@kernel.org>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org, Paul Mackerras <paulus@samba.org>, vincenzo.frascino@arm.com
List-Id: linux-arch.vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: a7f290dad32ee [PATCH] powerpc: Merge vdso's and add vdso support to 32 bits kernel.

The bot has tested the following trees: v5.1.4, v5.0.18, v4.19.45, v4.14.121, v4.9.178, v4.4.180, v3.18.140.

v5.1.4: Build OK!
v5.0.18: Build OK!
v4.19.45: Build OK!
v4.14.121: Failed to apply! Possible dependencies:
    5c929885f1bb4 ("powerpc/vdso64: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
    b5b4453e7912f ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")

v4.9.178: Failed to apply! Possible dependencies:
    4546561551106 ("powerpc/asm: Use OFFSET macro in asm-offsets.c")
    5c929885f1bb4 ("powerpc/vdso64: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
    5d451a87e5ebb ("powerpc/64: Retrieve number of L1 cache sets from device-tree")
    7c5b06cadf274 ("KVM: PPC: Book3S HV: Adapt TLB invalidations to work on POWER9")
    83677f551e0a6 ("KVM: PPC: Book3S HV: Adjust host/guest context switch for POWER9")
    902e06eb86cd6 ("powerpc/32: Change the stack protector canary value per task")
    b5b4453e7912f ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")
    bd067f83b0840 ("powerpc/64: Fix naming of cache block vs. cache line")
    e2827fe5c1566 ("powerpc/64: Clean up ppc64_caches using a struct per cache")
    e9cf1e085647b ("KVM: PPC: Book3S HV: Add new POWER9 guest-accessible SPRs")
    f4c51f841d2ac ("KVM: PPC: Book3S HV: Modify guest entry/exit paths to handle radix guests")

v4.4.180: Failed to apply! Possible dependencies:
    153086644fd1f ("powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI")
    3eb5d5888dc68 ("powerpc: Add ppc_strict_facility_enable boot option")
    4546561551106 ("powerpc/asm: Use OFFSET macro in asm-offsets.c")
    579e633e764e6 ("powerpc: create flush_all_to_thread()")
    5c929885f1bb4 ("powerpc/vdso64: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
    70fe3d980f5f1 ("powerpc: Restore FPU/VEC/VSX if previously used")
    85baa095497f3 ("powerpc/livepatch: Add live patching support on ppc64le")
    902e06eb86cd6 ("powerpc/32: Change the stack protector canary value per task")
    b5b4453e7912f ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")
    bf76f73c5f655 ("powerpc: enable UBSAN support")
    c208505900b23 ("powerpc: create giveup_all()")
    d1e1cf2e38def ("powerpc: clean up asm/switch_to.h")
    dc4fbba11e466 ("powerpc: Create disable_kernel_{fp,altivec,vsx,spe}()")
    f17c4e01e906c ("powerpc/module: Mark module stubs with a magic value")

v3.18.140: Failed to apply! Possible dependencies:
    10239733ee861 ("powerpc: Remove bootmem allocator")
    2449acc5348b9 ("powerpc/kernel: Enable seccomp filter")
    4546561551106 ("powerpc/asm: Use OFFSET macro in asm-offsets.c")
    49e4e15619cd7 ("tile: support CONTEXT_TRACKING and thus NOHZ_FULL")
    5c929885f1bb4 ("powerpc/vdso64: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
    73569d87e2cc5 ("MIPS: OCTEON: Enable little endian kernel.")
    817820b0226a1 ("powerpc/iommu: Support "hybrid" iommu/direct DMA ops for coherent_mask < dma_mask")
    83fe27ea53116 ("rcu: Make SRCU optional by using CONFIG_SRCU")
    85baa095497f3 ("powerpc/livepatch: Add live patching support on ppc64le")
    b01aec9b2c7d3 ("EDAC: Cleanup atomic_scrub mess")
    b30e759072c18 ("powerpc/mm: Switch to generic RCU get_user_pages_fast")
    b5b4453e7912f ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")
    bf76f73c5f655 ("powerpc: enable UBSAN support")
    c54b2bf1b5e99 ("powerpc: Add ppc64 hard lockup detector support")
    f30c59e921f12 ("mm: Update generic gup implementation to handle hugepage directory")
    f47436734dc89 ("tile: Use the more common pr_warn instead of pr_warning")


How should we proceed with this patch?

--
Thanks,
Sasha
