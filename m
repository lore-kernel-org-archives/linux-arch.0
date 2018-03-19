Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeCSMlN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Mar 2018 08:41:13 -0400
From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v3 0/3] Fix issues with huge mapping in ioremap for ARM64
Date: Mon, 19 Mar 2018 18:10:53 +0530
Message-ID: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com, Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <20180319124053.eXA0-Z3qdtMxBnkPLaYGp3VLljdlnNQAUYLV0uiUSso@z>

This series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

This series of patches are tested on 4.9 kernel with Cortex-A75
based SoC.

Chintan Pandya (3):
  ioremap: Update pgtable free interfaces with addr
  arm64: Implement page table free interfaces
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
