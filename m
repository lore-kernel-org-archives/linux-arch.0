From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 01/27] kbuild: remove useless $(gen) variable in Makefile.headersinst
Date: Mon, 12 Jun 2017 12:26:55 +0900
Message-ID: <1497238041-7011-2-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

We have no true case for the $(if $(gen), ...) conditional.  Drop it
to simplify the gendir calculation.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.headersinst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index ce753a408c56..c801bc129635 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -31,9 +31,6 @@ skip-inst := $(if $(filter %/uapi,$(obj)),1)
 
 ifeq ($(skip-inst),)
 
-# generated header directory
-gen := $(if $(gen),$(gen),$(subst include/,include/generated/,$(obj)))
-
 # Kbuild file is optional
 kbuild-file := $(srctree)/$(obj)/Kbuild
 -include $(kbuild-file)
@@ -45,7 +42,7 @@ endif
 
 installdir    := $(INSTALL_HDR_PATH)/$(subst uapi/,,$(_dst))
 
-gendir        := $(objtree)/$(gen)
+gendir        := $(objtree)/$(subst include/,include/generated/,$(obj))
 header-files  := $(notdir $(wildcard $(srcdir)/*.h))
 header-files  += $(notdir $(wildcard $(srcdir)/*.agh))
 header-files  := $(filter-out $(no-export-headers), $(header-files))
-- 
2.7.4

