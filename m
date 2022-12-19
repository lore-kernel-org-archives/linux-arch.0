Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB26C4332F
	for <linux-arch@archiver.kernel.org>; Mon, 19 Dec 2022 04:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLSE3l (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 18 Dec 2022 23:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiLSE27 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Dec 2022 23:28:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A32BF68;
        Sun, 18 Dec 2022 20:26:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6B4AB80D27;
        Mon, 19 Dec 2022 04:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7358DC433EF;
        Mon, 19 Dec 2022 04:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671423986;
        bh=hRycLOTdsoI0Dl/XQOcXlNVZnTaSLloe3NHNpvNTRgo=;
        h=From:To:Cc:Subject:Date:From;
        b=Oft5A7jUfir39CQjGSuN6VD5SuM0J18M9RnuI35aL7lqt6mu9cKKSo+qdouJVLx2X
         aVm8L1oBf2XiMQi/KKIoUj9rgkQlvBO1lJCcLM/9XohaheYVSog2/pIuFyayYg1aAg
         to1yZFvmH0H8BQs009eu13ks3MM/gT2sb2Oeq7Ohe+8mUrUV2IlqsBR2xCnfU/H4Vm
         9Z3CTbhxmhFQWqDl6yopLSRqhBhm7L2NzQTvNYQQm6qenBxVfvQ2Kr3UqcFBdiP44M
         ngPNDzY1Nut8gWnSKSsHbJt/A6yF9IqUPtvq2CS+V5a0LUPQkubKCmm4DlFsAXNBQV
         MNl/bjZThHLTA==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v6.2-rc1
Date:   Sun, 18 Dec 2022 23:26:22 -0500
Message-Id: <20221219042622.2621881-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Please pull the latest csky changes from:

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.2-rc1

for you to fetch changes up to 7e2004906fb52257772be0ef262fba2d5eb1653b:

  Revert "csky: Add support for restartable sequence" (2022-11-11 04:59:28 -0500)

----------------------------------------------------------------
arch/csky patches for 6.2-rc1

The pull request we've done:
 - Revert rseq
 - Add current_stack_pointer support
 - Typo fixup

----------------------------------------------------------------
Colin Ian King (1):
      csky: Kconfig: Fix spelling mistake "Meory" -> "Memory"

Mathieu Desnoyers (2):
      Revert "csky: Fixup CONFIG_DEBUG_RSEQ"
      Revert "csky: Add support for restartable sequence"

Tong Tiangen (1):
      csky: add arch support current_stack_pointer

 arch/csky/Kconfig                 |  4 ++--
 arch/csky/include/asm/processor.h |  2 ++
 arch/csky/kernel/entry.S          | 11 +----------
 arch/csky/kernel/signal.c         |  2 --
 arch/csky/kernel/stacktrace.c     |  6 ++----
 5 files changed, 7 insertions(+), 18 deletions(-)
