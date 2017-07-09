Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:45811 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbdGISdY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 14:33:24 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 26/28] kbuild: do not include old-kbuild-file from Makefile.headersinst
Date: Mon, 10 Jul 2017 03:32:58 +0900
Message-ID: <1499625180-8067-27-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
Message-ID: <20170709183258.VtsJptI645jSFCB_pTEY_CQFgNg4-iDgBYJlsx9YSv4@z>

Now asm-generic wrappers to be exported are all listed in
arch/*/include/uapi/asm/Kbuild.  "make headers_install" no longer
depends on any Kbuild files outside uapi directories.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.headersinst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index e9147f05ea77..e6343b34182a 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -40,11 +40,6 @@ ifeq ($(skip-inst),)
 kbuild-file := $(srctree)/$(obj)/Kbuild
 -include $(kbuild-file)
 
-old-kbuild-file := $(srctree)/$(subst uapi/,,$(obj))/Kbuild
-ifneq ($(wildcard $(old-kbuild-file)),)
-include $(old-kbuild-file)
-endif
-
 installdir    := $(INSTALL_HDR_PATH)/$(dst)
 gendir        := $(objtree)/$(subst include/,include/generated/,$(obj))
 header-files  := $(notdir $(wildcard $(srcdir)/*.h))
-- 
2.7.4
