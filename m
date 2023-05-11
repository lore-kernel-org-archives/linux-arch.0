Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374BFC77B7F
	for <linux-arch@archiver.kernel.org>; Thu, 11 May 2023 14:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbjEKOXo (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 11 May 2023 10:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbjEKOXg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 10:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9F7E66;
        Thu, 11 May 2023 07:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F86264DFE;
        Thu, 11 May 2023 14:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991FBC433D2;
        Thu, 11 May 2023 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683815000;
        bh=RBBjQJhyNTq4SLepJRhrNnLCCMrJFLXtNe6TLcXndOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DuTL2omz4fj1qRlJSZXZGLrBNoL39rBeuQpXk/KjnbC+dCNf4/gp6IJF22P4VJuTU
         5Kur7PM3FMd7AFMbVodq9zu/bH7kktW8XkJ/+PzymDCAmEDBvrAVzrwE0/Mpf1vDE1
         Q2XB19rffNaqwD2DN8kZ6kNDnulVKfEHfvS3yxAbb1XgXJ5V+R3dx3NRkVLL0mar8Z
         +ajhWfJ0YLRTSbzTAv/aBaYgFmApf55tt4Rj18Bw1AzC6bbl+43pkg3Jr3oihI0ArN
         QM1onojNiOUFyt2IN193TDX3CeEGQXKyAnG5QVCT98vT4fjeFY9pIUDhiRljGoGKi4
         0MOl+1qd56rVw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 1/4] riscv: vmlinux-xip.lds.S: remove .alternative section
Date:   Thu, 11 May 2023 22:12:08 +0800
Message-Id: <20230511141211.2418-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511141211.2418-1-jszhang@kernel.org>
References: <20230511141211.2418-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ALTERNATIVE mechanism can't work on XIP, and this is also reflected by
below Kconfig dependency:

RISCV_ALTERNATIVE
	...
	depends on !XIP_KERNEL
	...

So there's no .alternative section at all for XIP case, remove it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vmlinux-xip.lds.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
index eab9edc3b631..50767647fbc6 100644
--- a/arch/riscv/kernel/vmlinux-xip.lds.S
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -98,12 +98,6 @@ SECTIONS
 		__soc_builtin_dtb_table_end = .;
 	}
 
-	. = ALIGN(8);
-	.alternative : {
-		__alt_start = .;
-		*(.alternative)
-		__alt_end = .;
-	}
 	__init_end = .;
 
 	. = ALIGN(16);
-- 
2.40.1

