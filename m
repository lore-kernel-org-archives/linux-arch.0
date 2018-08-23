From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 1/2] kbuild: pass LDFLAGS to recordmcount.pl
Date: Fri, 24 Aug 2018 08:20:38 +0900
Message-ID: <1535066439-11259-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-arch.vger.kernel.org

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
