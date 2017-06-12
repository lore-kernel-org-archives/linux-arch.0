From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 03/27] kbuild: pass dst= to Makefile.headersinst from top Makefile
Date: Mon, 12 Jun 2017 12:26:57 +0900
Message-ID: <1497238041-7011-4-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:63914 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdFLD2F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Jun 2017 23:28:05 -0400
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org

We can always pass dst= from the top Makefile.  This will simplify
the logic in Makefile.headersinst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                     | 4 ++--
 scripts/Makefile.headersinst | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 298a096863a9..1bb8c07db134 100644
--- a/Makefile
+++ b/Makefile
@@ -1162,7 +1162,7 @@ PHONY += headers_install
 headers_install: __headers
 	$(if $(wildcard $(srctree)/arch/$(hdr-arch)/include/uapi/asm/Kbuild),, \
 	  $(error Headers not exportable for the $(SRCARCH) architecture))
-	$(Q)$(MAKE) $(hdr-inst)=include/uapi
+	$(Q)$(MAKE) $(hdr-inst)=include/uapi dst=include
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/uapi $(hdr-dst)
 
 PHONY += headers_check_all
@@ -1171,7 +1171,7 @@ headers_check_all: headers_install_all
 
 PHONY += headers_check
 headers_check: headers_install
-	$(Q)$(MAKE) $(hdr-inst)=include/uapi HDRCHECK=1
+	$(Q)$(MAKE) $(hdr-inst)=include/uapi dst=include HDRCHECK=1
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/uapi $(hdr-dst) HDRCHECK=1
 
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index c801bc129635..b3135b76fac2 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -15,15 +15,13 @@ include scripts/Kbuild.include
 
 srcdir        := $(srctree)/$(obj)
 subdirs       := $(patsubst $(srcdir)/%/.,%,$(wildcard $(srcdir)/*/.))
-# caller may set destination dir (when installing to asm/)
-_dst          := $(if $(dst),$(dst),$(obj))
 
 # Recursion
 __headers: $(subdirs)
 
 .PHONY: $(subdirs)
 $(subdirs):
-	$(Q)$(MAKE) $(hdr-inst)=$(obj)/$@ dst=$(_dst)/$@
+	$(Q)$(MAKE) $(hdr-inst)=$(obj)/$@ dst=$(dst)/$@
 
 # Skip header install/check for include/uapi and arch/$(hdr-arch)/include/uapi.
 # We have only sub-directories there.
@@ -40,8 +38,7 @@ ifneq ($(wildcard $(old-kbuild-file)),)
 include $(old-kbuild-file)
 endif
 
-installdir    := $(INSTALL_HDR_PATH)/$(subst uapi/,,$(_dst))
-
+installdir    := $(INSTALL_HDR_PATH)/$(dst)
 gendir        := $(objtree)/$(subst include/,include/generated/,$(obj))
 header-files  := $(notdir $(wildcard $(srcdir)/*.h))
 header-files  += $(notdir $(wildcard $(srcdir)/*.agh))
-- 
2.7.4
