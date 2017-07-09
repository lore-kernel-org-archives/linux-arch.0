From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 03/28] kbuild: pass dst= to Makefile.headersinst from top Makefile
Date: Mon, 10 Jul 2017 03:32:35 +0900
Message-ID: <1499625180-8067-4-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

We can always pass dst= from the top Makefile.  This will simplify
the logic in Makefile.headersinst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                     | 4 ++--
 scripts/Makefile.headersinst | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index ce5875628740..70c414b15859 100644
--- a/Makefile
+++ b/Makefile
@@ -1154,7 +1154,7 @@ PHONY += headers_install
 headers_install: __headers
 	$(if $(wildcard $(srctree)/arch/$(hdr-arch)/include/uapi/asm/Kbuild),, \
 	  $(error Headers not exportable for the $(SRCARCH) architecture))
-	$(Q)$(MAKE) $(hdr-inst)=include/uapi
+	$(Q)$(MAKE) $(hdr-inst)=include/uapi dst=include
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/uapi $(hdr-dst)
 
 PHONY += headers_check_all
@@ -1163,7 +1163,7 @@ headers_check_all: headers_install_all
 
 PHONY += headers_check
 headers_check: headers_install
-	$(Q)$(MAKE) $(hdr-inst)=include/uapi HDRCHECK=1
+	$(Q)$(MAKE) $(hdr-inst)=include/uapi dst=include HDRCHECK=1
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(hdr-arch)/include/uapi $(hdr-dst) HDRCHECK=1
 
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 4e9287bfdf28..e9147f05ea77 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -23,15 +23,12 @@ subdirs       := $(patsubst $(srcdir)/%/,%,\
 		 $(filter-out $(srcdir)/,\
 		 $(sort $(dir $(wildcard $(srcdir)/*/)))))
 
-# caller may set destination dir (when installing to asm/)
-_dst          := $(if $(dst),$(dst),$(obj))
-
 # Recursion
 __headers: $(subdirs)
 
 .PHONY: $(subdirs)
 $(subdirs):
-	$(Q)$(MAKE) $(hdr-inst)=$(obj)/$@ dst=$(_dst)/$@
+	$(Q)$(MAKE) $(hdr-inst)=$(obj)/$@ dst=$(dst)/$@
 
 # Skip header install/check for include/uapi and arch/$(hdr-arch)/include/uapi.
 # We have only sub-directories there.
@@ -48,8 +45,7 @@ ifneq ($(wildcard $(old-kbuild-file)),)
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
