From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5 1/3] powerpc: Fix vDSO clock_getres()
Date: Tue, 04 Jun 2019 12:50:47 +0000
Message-ID: <20190604125048.78C02249CE@mail.kernel.org>
References: <20190528120446.48911-2-vincenzo.frascino@arm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190528120446.48911-2-vincenzo.frascino@arm.com>
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
fixing commit: a7f290dad32e [PATCH] powerpc: Merge vdso's and add vdso support to 32 bits kernel.

The bot has tested the following trees: v5.1.6, v5.0.20, v4.19.47, v4.14.123, v4.9.180, v4.4.180.

v5.1.6: Build OK!
v5.0.20: Build OK!
v4.19.47: Build OK!
v4.14.123: Failed to apply! Possible dependencies:
    5c929885f1bb ("powerpc/vdso64: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
    b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")

v4.9.180: Failed to apply! Possible dependencies:
    454656155110 ("powerpc/asm: Use OFFSET macro in asm-offsets.c")
    5c929885f1bb ("powerpc/vdso64: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
    5d451a87e5eb ("powerpc/64: Retrieve number of L1 cache sets from device-tree")
    7c5b06cadf27 ("KVM: PPC: Book3S HV: Adapt TLB invalidations to work on POWER9")
    83677f551e0a ("KVM: PPC: Book3S HV: Adjust host/guest context switch for POWER9")
    902e06eb86cd ("powerpc/32: Change the stack protector canary value per task")
    b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")
    bd067f83b084 ("powerpc/64: Fix naming of cache block vs. cache line")
    e2827fe5c156 ("powerpc/64: Clean up ppc64_caches using a struct per cache")
    e9cf1e085647 ("KVM: PPC: Book3S HV: Add new POWER9 guest-accessible SPRs")
    f4c51f841d2a ("KVM: PPC: Book3S HV: Modify guest entry/exit paths to handle radix guests")

v4.4.180: Failed to apply! Possible dependencies:
    153086644fd1 ("powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI")
    3eb5d5888dc6 ("powerpc: Add ppc_strict_facility_enable boot option")
    454656155110 ("powerpc/asm: Use OFFSET macro in asm-offsets.c")
    579e633e764e ("powerpc: create flush_all_to_thread()")
    5c929885f1bb ("powerpc/vdso64: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
    70fe3d980f5f ("powerpc: Restore FPU/VEC/VSX if previously used")
    85baa095497f ("powerpc/livepatch: Add live patching support on ppc64le")
    902e06eb86cd ("powerpc/32: Change the stack protector canary value per task")
    b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")
    bf76f73c5f65 ("powerpc: enable UBSAN support")
    c208505900b2 ("powerpc: create giveup_all()")
    d1e1cf2e38de ("powerpc: clean up asm/switch_to.h")
    dc4fbba11e46 ("powerpc: Create disable_kernel_{fp,altivec,vsx,spe}()")
    f17c4e01e906 ("powerpc/module: Mark module stubs with a magic value")


How should we proceed with this patch?

--
Thanks,
Sasha
