Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbeC1K7O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Mar 2018 06:59:14 -0400
From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v6 1/4] ioremap: Update pgtable free interfaces with addr
Date: Wed, 28 Mar 2018 16:28:48 +0530
Message-ID: <1522234731-27397-2-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
References: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <20180328105848.VeIFV48GdY7N7Ct3lkVDozMerZaKN_JG8GC0chYzn_0@z>

This patch ("mm/vmalloc: Add interfaces to free unmapped
page table") adds following 2 interfaces to free the page
table in case we implement huge mapping.

pud_free_pmd_page() and pmd_free_pte_page()

Some architectures (like arm64) needs to do proper TLB
maintanance after updating pagetable entry even in map.
Why ? Read this,
https://patchwork.kernel.org/patch/10134581/

Pass 'addr' in these interfaces so that proper TLB ops
can be performed.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
