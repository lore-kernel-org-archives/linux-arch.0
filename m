Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeCOMpW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 08:45:22 -0400
From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Thu, 15 Mar 2018 18:15:02 +0530
Message-ID: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com, Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <20180315124502.0G8ckmzxB33mMuTrgRNI1pUs-SohyOPu4fVFWppY0b4@z>

These series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

IOREMAP code has been touched up to honor BBM which is
requirement for some arch (like arm64) and works well
with all other.

Chintan Pandya (4):
  asm/tlbflush: Add flush_tlb_pgtable() for ARM64
  ioremap: Implement TLB_INV before huge mapping
  arm64: Implement page table free interfaces
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
