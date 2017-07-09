From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 27/28] kbuild: split exported generic header creation into uapi-asm-generic
Date: Mon, 10 Jul 2017 03:32:59 +0900
Message-ID: <1499625180-8067-28-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

When we install headers, we are interested only in headers under uapi
directories.  Split out uapi-asm-generic target and make headers_install
depend on it.  It will avoid generating unneeded asm-generic wrappers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 70c414b15859..f75a93fa9975 100644
--- a/Makefile
+++ b/Makefile
@@ -456,10 +456,11 @@ ifneq ($(KBUILD_SRC),)
 endif
 
 # Support for using generic headers in asm-generic
-PHONY += asm-generic
-asm-generic:
+PHONY += asm-generic uapi-asm-generic
+asm-generic: uapi-asm-generic
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
 	            src=asm obj=arch/$(SRCARCH)/include/generated/asm
+uapi-asm-generic:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
 	            src=uapi/asm obj=arch/$(SRCARCH)/include/generated/uapi/asm
 
@@ -1143,7 +1144,7 @@ PHONY += archscripts
 archscripts:
 
 PHONY += __headers
-__headers: $(version_h) scripts_basic asm-generic archheaders archscripts
+__headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
 	$(Q)$(MAKE) $(build)=scripts build_unifdef
 
 PHONY += headers_install_all
-- 
2.7.4
