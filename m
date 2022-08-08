Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312FBC00140
	for <linux-arch@archiver.kernel.org>; Mon,  8 Aug 2022 08:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiHHIGQ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 8 Aug 2022 04:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiHHIGP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 04:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD4ECE3B;
        Mon,  8 Aug 2022 01:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A7160E2D;
        Mon,  8 Aug 2022 08:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BABC433D6;
        Mon,  8 Aug 2022 08:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659945974;
        bh=oLo+n26XWd3Bl2frOxEyB9f9Z0LptPcBWpJCu34gpUM=;
        h=From:To:Cc:Subject:Date:From;
        b=NBP7I4zu+ChMiZAGQwQY7PKIZ8DPlfIGuoGznAOeyiMteNDhK+gfLR6Mr7LrP8ISY
         1qdQUUJR0bBiLcrWuJkoOsHcQsuHRIpiwc+BC7DyZrEP76tgtH8UhKdXMS2wjkkkEe
         mfTgsuVlDFv32dExH+oV+i/38Zu0zdnp2gDhlaSdOE7xLzX+dHNrOnPScWne+KQ27F
         BBkAO0iJu9G/aMD6vHavoql34N0aznZpvpSlVQ3hS0419uX302t7Wy2YOd0bRonRII
         W94+wdStPM+Bto628pRcRLb5WXqiuKgnGvjAJ8976SQ3SzCX3H7DYE7nXeIZFyELhv
         Lz0oyICr+akOw==
From:   guoren@kernel.org
To:     tj@kernel.org, cl@linux.com, palmer@dabbelt.com, will@kernel.org,
        catalin.marinas@arm.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 0/4] riscv: Add basic percpu operations
Date:   Mon,  8 Aug 2022 04:05:56 -0400
Message-Id: <20220808080600.3346843-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The series try to add basic percpu operations for riscv. HAVE_CMPXCHG_LOCAL
would let people confuse with cmpxchg(64)_local, so make the name more
accurate (HAVE_CMPXCHG_PERCPU_BYTE). Last, remove RISC-V's
cmpxchg(64)_local definition because it's no use.

Guo Ren (4):
  vmstat: percpu: Rename HAVE_CMPXCHG_LOCAL to HAVE_CMPXCHG_PERCPU_BYTE
  arm64: percpu: Use generic PERCPU_RW_OPS
  riscv: percpu: Implement this_cpu operations
  riscv: cmpxchg: Remove unused cmpxchg(64)_local

 .../locking/cmpxchg-local/arch-support.txt    |   6 +-
 arch/Kconfig                                  |   2 +-
 arch/arm64/Kconfig                            |   2 +-
 arch/arm64/include/asm/percpu.h               |  33 ------
 arch/riscv/include/asm/cmpxchg.h              |   9 --
 arch/riscv/include/asm/percpu.h               | 104 ++++++++++++++++++
 arch/s390/Kconfig                             |   2 +-
 arch/x86/Kconfig                              |   2 +-
 mm/vmstat.c                                   |   4 +-
 9 files changed, 113 insertions(+), 51 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.36.1

