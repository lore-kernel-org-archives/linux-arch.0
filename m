Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:53324 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeHXCwt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Aug 2018 22:52:49 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 1/2] kbuild: pass LDFLAGS to recordmcount.pl
Date: Fri, 24 Aug 2018 08:20:38 +0900
Message-ID: <1535066439-11259-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
Message-ID: <20180823232038.QJgKTZrEbeDD5X9BuouVdAviNxUhPifkbLRVtd2Yjr4@z>

Since commit 0fbe9a245c60 ("microblaze: add endianness options to
LDFLAGS instead of LD"), you cannot build the kernel for microblaze
with CONFIG_DYNAMIC_FTRACE.

Fixes: 0fbe9a245c60 ("microblaze: add endianness options to LDFLAGS instead of LD")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - New patch

Changes in v2: None

 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 93b8e24..f5d7612 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -220,7 +220,7 @@ sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
-	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \
+	"$(LD) $(LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
-- 
2.7.4
