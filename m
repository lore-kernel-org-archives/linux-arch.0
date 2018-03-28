Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeC1Mbi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Mar 2018 08:31:38 -0400
From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v7 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Wed, 28 Mar 2018 18:01:18 +0530
Message-ID: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <20180328123118.9Rco2P4JStjA1xi-XDMhmAwSsMNeOUk2dO8rsGgMMks@z>

This series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

This series of patches are tested on 4.9 kernel with Cortex-A75
based SoC.

These patches can also go into '-stable' branch (if accepted)
for 4.6 onwards.
