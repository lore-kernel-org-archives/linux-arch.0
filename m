Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3766C433F5
	for <linux-arch@archiver.kernel.org>; Tue, 12 Apr 2022 03:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbiDLDwd (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 11 Apr 2022 23:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbiDLDwc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 23:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCD215A3E;
        Mon, 11 Apr 2022 20:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA3061735;
        Tue, 12 Apr 2022 03:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B31C385A6;
        Tue, 12 Apr 2022 03:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649735415;
        bh=P9+O1kpUptYnKFD23NWAw1Xn9Hh0s8Rg+gBWuVO+Hew=;
        h=From:To:Cc:Subject:Date:From;
        b=dRKJ8Ovtpx0hFHCkElq0iMIL9BZ98ES/fbm4BQOSUJP+Ag9nH9qE1JChNSS9cQkRw
         IC2Fz5AXrSN6R5Kzlq7fB9yKqZwdMRGfxNZS/FzW87ig19Doc/z3rQLrcJl4r2QGqc
         RySZEYOZq/8CagzXX3CdP/nxKjp9BhJYNKE8MMm/Tz07ebnvNGG2EHgM7j4fY3M9yd
         YDH7fwe1r9r+ml4VoryrMUHa/ITMSWAGs0z/ZbdN1XYS+BvKXIX2XSI0jYCK4m3MsN
         I41hxKxwaPFhS5EH5dq7D6C1Hch0SJ4ZO6WEwsNAfQsDmlcY5RhNYMwC586Db4jXlc
         jOwjOyHOaMV6w==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
Date:   Tue, 12 Apr 2022 11:49:54 +0800
Message-Id: <20220412034957.1481088-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

These patch series contain one cleanup and some optimizations for
atomic operations.

Changes in V2:
 - Fixup LR/SC memory barrier semantic problems which pointed by
   Rutland
 - Combine patches into one patchset series
 - Separate AMO optimization & LRSC optimization for convenience
   patch review

Guo Ren (3):
  riscv: atomic: Cleanup unnecessary definition
  riscv: atomic: Optimize acquire and release for AMO operations
  riscv: atomic: Optimize memory barrier semantics of LRSC-pairs

 arch/riscv/include/asm/atomic.h  | 70 ++++++++++++++++++++++++++++++--
 arch/riscv/include/asm/cmpxchg.h | 42 +++++--------------
 2 files changed, 76 insertions(+), 36 deletions(-)

-- 
2.25.1

