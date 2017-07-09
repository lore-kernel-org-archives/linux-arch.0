From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 13/28] m32r: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 10 Jul 2017 03:32:45 +0900
Message-ID: <1499625180-8067-14-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), all (and only) headers under uapi directories are
exported, but asm-generic wrappers are still exceptions.

To complete de-coupling the uapi from kernel headers, move generic-y
of exported headers to uapi/asm/Kbuild.

With this change, "make headers_install" will just need to parse
uapi/asm/Kbuild to build up exported headers.

Also, move "generic-y += kprobes.h" up in order to keep the entries
sorted.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/m32r/include/asm/Kbuild      | 4 +---
 arch/m32r/include/uapi/asm/Kbuild | 3 ++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index c000ffac8586..7e11b125c35e 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -1,10 +1,9 @@
-
 generic-y += clkdev.h
 generic-y += current.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += irq_work.h
-generic-y += kvm_para.h
+generic-y += kprobes.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += module.h
@@ -12,4 +11,3 @@ generic-y += preempt.h
 generic-y += sections.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
-generic-y += kprobes.h
diff --git a/arch/m32r/include/uapi/asm/Kbuild b/arch/m32r/include/uapi/asm/Kbuild
index c94ee54210bc..1c44d3b3eba0 100644
--- a/arch/m32r/include/uapi/asm/Kbuild
+++ b/arch/m32r/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y	+= siginfo.h
+generic-y += kvm_para.h
+generic-y += siginfo.h
-- 
2.7.4

