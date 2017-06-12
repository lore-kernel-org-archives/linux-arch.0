From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 26/27] kbuild: split exported generic header creation into uapi-asm-generic
Date: Mon, 12 Jun 2017 12:27:20 +0900
Message-ID: <1497238041-7011-27-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

When we install headers, we are interested only in headers under uapi
directories.  Split out uapi-asm-generic target and make headers_install
depend on it.  It will avoid generating unneeded asm-generic wrappers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 1bb8c07db134..4fe556511c0d 100644
--- a/Makefile
+++ b/Makefile
@@ -465,10 +465,11 @@ ifneq ($(KBUILD_SRC),)
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
 
@@ -1151,7 +1152,7 @@ PHONY += archscripts
 archscripts:
 
 PHONY += __headers
-__headers: $(version_h) scripts_basic asm-generic archheaders archscripts
+__headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
 	$(Q)$(MAKE) $(build)=scripts build_unifdef
 
 PHONY += headers_install_all
-- 
2.7.4
