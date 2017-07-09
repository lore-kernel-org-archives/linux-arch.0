Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:45692 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbdGISdR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 14:33:17 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 01/28] kbuild: remove useless $(gen) variable in Makefile.headersinst
Date: Mon, 10 Jul 2017 03:32:33 +0900
Message-ID: <1499625180-8067-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
Message-ID: <20170709183233.I3gfJjskuWxTSpnjPsiwJijCKEYJYRBBp1mBCU_mjD4@z>

We have no true case for the $(if $(gen), ...) conditional.  Drop it
to simplify the gendir calculation.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.headersinst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index c583a1e1bd3c..4e9287bfdf28 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -39,9 +39,6 @@ skip-inst := $(if $(filter %/uapi,$(obj)),1)
 
 ifeq ($(skip-inst),)
 
-# generated header directory
-gen := $(if $(gen),$(gen),$(subst include/,include/generated/,$(obj)))
-
 # Kbuild file is optional
 kbuild-file := $(srctree)/$(obj)/Kbuild
 -include $(kbuild-file)
@@ -53,7 +50,7 @@ endif
 
 installdir    := $(INSTALL_HDR_PATH)/$(subst uapi/,,$(_dst))
 
-gendir        := $(objtree)/$(gen)
+gendir        := $(objtree)/$(subst include/,include/generated/,$(obj))
 header-files  := $(notdir $(wildcard $(srcdir)/*.h))
 header-files  += $(notdir $(wildcard $(srcdir)/*.agh))
 header-files  := $(filter-out $(no-export-headers), $(header-files))
-- 
2.7.4
