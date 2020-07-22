From: David Brazdil <dbrazdil@google.com>
Subject: [PATCH 0/9] Independent per-CPU data section for nVHE
Date: Wed, 22 Jul 2020 17:44:15 +0100
Message-ID: <20200722164424.42225-1-dbrazdil@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGVQpB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B1C0619DC
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so2543391wrl.8
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:00 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc: James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, kernel-team@google.com, David Brazdil <dbrazdil@google.com>

Introduce '.hyp.data..percpu' as part of ongoing effort to make nVHE
hyp code self-contained and independent of the rest of the kernel.

The series builds on top of the "Split off nVHE hyp code" series which
used objcopy to rename '.text' to '.hyp.text' and prefix all ELF
symbols with '__kvm_nvhe' for all object files under kvm/hyp/nvhe.

The series is structured as follows:

 - patch 1: Modify generic PERCPU_* linker script macros to make it
     possible to define multiple per-CPU ELF sections with prefixed
     section and symbol names.

 - patches 2-3: Replace hyp helpers for accessing per-CPU variables
     with common helpers modified to work correctly in hyp. Per-CPU
     variables can now be accessed with one API anywhere.

 - patches 4-6: Where VHE and nVHE use per-CPU variables defined in
     kernel proper, move their definitions to hyp/ where they are
     duplicated and owned by VHE/nVHE, respectively. Non-VHE hyp code
     now refers only to per-CPU variables defined in its source files.
     Helpers are added so that kernel proper can continue to access
     nVHE hyp variables, same way as it does with other nVHE symbols.

 - patches 7-9: Introduce '.hyp.data..percpu' ELF section and allocate
     memory for every CPU core during KVM init. All nVHE per-CPU state
     is now grouped together in ELF and in memory. Introducing a new
     per-CPU variable does not require adding new memory mappings any
     more. nVHE hyp code cannot accidentally refer to kernel-proper
     per-CPU data as it only has the pointer to its own per-CPU memory.

The patches are rebased on current kvmarm/next (commit b72eb1f6813)
and are available in branch 'topic/percpu' at:
    https://android-kvm.googlesource.com/linux

David Brazdil (9):
  Macros to override naming of percpu symbols and sections
  kvm: arm64: Remove __hyp_this_cpu_read
  kvm: arm64: Remove hyp_adr/ldr_this_cpu
  kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
  kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
  kvm: arm64: Create separate instances of kvm_host_data for VHE/nVHE
  kvm: arm64: Mark hyp stack pages reserved
  kvm: arm64: Set up hyp percpu data for nVHE
  kvm: arm64: Remove unnecessary hyp mappings

 arch/arm64/include/asm/assembler.h        |  27 ++++--
 arch/arm64/include/asm/kvm_asm.h          |  74 ++++++++-------
 arch/arm64/include/asm/kvm_host.h         |   2 +-
 arch/arm64/include/asm/kvm_mmu.h          |  23 ++---
 arch/arm64/include/asm/percpu.h           |  33 ++++++-
 arch/arm64/include/asm/sections.h         |   1 +
 arch/arm64/kernel/image-vars.h            |   2 -
 arch/arm64/kernel/vmlinux.lds.S           |  10 ++
 arch/arm64/kvm/arm.c                      | 110 ++++++++++++++++++----
 arch/arm64/kvm/hyp/hyp-entry.S            |   2 +-
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h   |   6 +-
 arch/arm64/kvm/hyp/nvhe/Makefile          |   2 +
 arch/arm64/kvm/hyp/nvhe/switch.c          |   8 +-
 arch/arm64/kvm/hyp/vhe/switch.c           |   5 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |   4 +-
 arch/arm64/kvm/pmu.c                      |  13 ++-
 include/asm-generic/vmlinux.lds.h         |  40 +++++---
 18 files changed, 257 insertions(+), 109 deletions(-)

-- 
2.27.0
