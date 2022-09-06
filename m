Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DCFECAAA1
	for <linux-arch@archiver.kernel.org>; Tue,  6 Sep 2022 03:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiIFDzH (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 5 Sep 2022 23:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiIFDyy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 23:54:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C512742;
        Mon,  5 Sep 2022 20:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1E89B81604;
        Tue,  6 Sep 2022 03:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B5BC433B5;
        Tue,  6 Sep 2022 03:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662436489;
        bh=RGP7CDjbcyHeNMuZLodmYJfbkQkcESukcz8ylbmajf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHgOWGK4VoTfDyBgo6InDAKLQmogRc8s3ka5Ds+OQ3eLDaHrvdu9GKlZyZveLwAVA
         NVE4/0WdUSwhbtP9pducgWfRNhoFK2fxm7yIAn6BKh0lbtxCxt0XytV1NO1665Ptto
         Oa7DU3nj/Y+05M3E2zJWValIHEwiGwasVN4vekv53c5vIMFXkJAb+hJh1JxQ7oCjc2
         VmLTrF4n45cF1bTTqBvIvnuAJbQoGxqD/I5ZEzQnio5CsV4kG4ZXzeq3dN/yBp2SE4
         tFTdaiS5wH71klJs1gCexoVET+6gy2mzWKG2+R02mNz4Ogk58PAKpmmIqjjWK3jVrM
         igkGdW1IYfGnQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH V3 2/7] riscv: compat_syscall_table: Fixup compile warning
Date:   Mon,  5 Sep 2022 23:54:18 -0400
Message-Id: <20220906035423.634617-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220906035423.634617-1-guoren@kernel.org>
References: <20220906035423.634617-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

../arch/riscv/kernel/compat_syscall_table.c:12:41: warning: initialized
field overwritten [-Woverride-init]
   12 | #define __SYSCALL(nr, call)      [nr] = (call),
      |                                         ^
../include/uapi/asm-generic/unistd.h:567:1: note: in expansion of macro
'__SYSCALL'
  567 | __SYSCALL(__NR_semget, sys_semget)

Fixes: 59c10c52f573 ("riscv: compat: syscall: Add compat_sys_call_table implementation")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/riscv/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 33bb60a354cd..01da14e21019 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -9,6 +9,7 @@ CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
+CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
 
 ifdef CONFIG_KEXEC
 AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
-- 
2.36.1

