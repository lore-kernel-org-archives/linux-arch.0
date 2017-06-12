From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 21/27] sparc: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:27:15 +0900
Message-ID: <1497238041-7011-22-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), all (and only) headers under uapi directories are
exported, but asm-generic wrappers are still exceptions.

scripts/Makefile.headersinst still need to deal with old-kbuild-file
for headers listed in arch/*/include/asm/Kbuild, but actually exported.

As the last work to finish de-coupling the uapi from kernel headers,
move generic-y of exported headers to uapi/asm/Kbuild.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sparc/include/asm/Kbuild      | 1 -
 arch/sparc/include/uapi/asm/Kbuild | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index e9e837bc3158..80ddc01f57ac 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -18,5 +18,4 @@ generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += serial.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += word-at-a-time.h
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index b15bf6bc0e94..2178c78c7c1a 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -1,2 +1,4 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
+
+generic-y += types.h
-- 
2.7.4
