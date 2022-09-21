Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A09C32771
	for <linux-arch@archiver.kernel.org>; Wed, 21 Sep 2022 03:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiIUDti (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 20 Sep 2022 23:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiIUDt2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 23:49:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F9A7C321;
        Tue, 20 Sep 2022 20:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76206B82433;
        Wed, 21 Sep 2022 03:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912DAC433B5;
        Wed, 21 Sep 2022 03:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663732165;
        bh=Iig2bmqX2xPq4svTTL0eg2AIxZh7cd/4Rrn/f1KZwI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHv1P1cxYrDQ4irReok/MJi/zVEpjKmZTJ5o+uOxY+sowAozNgRUvjCOC4p/6jkZe
         mDaYv8lsmlaXSvNX1+GPOTpn/RH43YPt0aa8SaC/5b98jdoOToRRih/iEVmma+u5t/
         L1UlDuGFbE6XfETSX0EAiNblpJN9I37skiKYqgiuvB38Wz7OajoXml9xTQFI2LXwtG
         TLJVKEWjG6szoWPzw7QkGt9DEioQtHXGCNH4h5iBKJ64qkALtKQJiTqZKHvg0iDL7p
         xGg95iOdZmyaqvmPt5jb5UyqfV1w5oGPoWa9d7bj1r60TgKCcuoGy025PhjvOQpkkB
         9nspWJn2399UQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, palmer@rivosinc.com, rostedt@goodmis.org,
        andy.chiu@sifive.com, greentime.hu@sifive.com, zong.li@sifive.com,
        jrtc27@jrtc27.com, mingo@redhat.com, palmer@dabbelt.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@kernel.org
Subject: [PATCH V2 1/3] riscv: ftrace: Fixup panic by disabling preemption
Date:   Tue, 20 Sep 2022 23:49:08 -0400
Message-Id: <20220921034910.3142465-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220921034910.3142465-1-guoren@kernel.org>
References: <20220921034910.3142465-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andy Chiu <andy.chiu@sifive.com>

In RISCV, we must use an AUIPC + JALR pair to encode an immediate,
forming a jump that jumps to an address over 4K. This may cause errors
if we want to enable kernel preemption and remove dependency from
patching code with stop_machine(). For example, if a task was switched
out on auipc. And, if we changed the ftrace function before it was
switched back, then it would jump to an address that has updated 11:0
bits mixing with previous XLEN:12 part.

p: patched area performed by dynamic ftrace
ftrace_prologue:
p|      REG_S   ra, -SZREG(sp)
p|      auipc   ra, 0x? ------------> preempted
					...
				change ftrace function
					...
p|      jalr    -?(ra) <------------- switched back
p|      REG_L   ra, -SZREG(sp)
func:
	xxx
	ret

Fixes: fc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
@Andy, could you give the patch a Signed-off-by? I just copy your most
important comment, so the first author should be you. First, let's fix
the problem caused by my previous patch, and you can continue your
ftrace preemption work.
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ed66c31e4655..b3454c843932 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -272,7 +272,7 @@ config ARCH_RV64I
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 	select SWIOTLB if MMU
 
 endchoice
-- 
2.36.1

