Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeD3Hlx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2018 03:41:53 -0400
From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v9 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Mon, 30 Apr 2018 13:11:30 +0530
Message-ID: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Philip Elcan <pelcan@codeaurora.org>, James Morse <james.morse@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>, Toshi Kani <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <20180430074130.628i3-YVBDtwTcE1qE5xPcvmVbY5nhLTABKRwz_VyhA@z>

This series of patches takes Toshi Kani <toshi.kani@hpe.com>'s
patches ("fix memory leak/panic in ioremap huge pages") as base
and re-bring huge_vmap back for arm64.

This series of patches are tested on 4.16 kernel with Cortex-A75
based SoC.

The test used for verifying these patches is a stress test on
ioremap/unmap which tries to re-use same io-address but changes
size of mapping randomly i.e. 4K to 2M to 16K etc. The same test
used to reproduce 3rd level translation fault without these fixes
(and also of course with Revert "arm64: Enforce BBM for huge IO/VMAP
mappings" being part of the tree).

These patches can also go into '-stable' branch (if accepted)
for 4.6 onwards.
