Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35064 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752269AbeC1K71 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Mar 2018 06:59:27 -0400
From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v6 1/2] arm64: Implement page table free interfaces
Date: Wed, 28 Mar 2018 16:28:50 +0530
Message-ID: <1522234731-27397-4-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
References: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <20180328105850.FVLrMkU8i0l8Dt68EiVY_KC5d5BMWPrB1ccZMrQmxjc@z>

Implement pud_free_pmd_page() and pmd_free_pte_page().

Implementation requires,
 1) Clearing off the current pud/pmd entry
 2) Invalidate TLB which could have previously
    valid but not stale entry
 3) Freeing of the un-used next level page tables

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
