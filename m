Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:45702 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdGISdR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 14:33:17 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 02/28] kbuild: fix comment about dst of headers_{install,check}_all
Date: Mon, 10 Jul 2017 03:32:34 +0900
Message-ID: <1499625180-8067-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
Message-ID: <20170709183234.zZScU53itsQeGWsycdAZ01CAkiYvQUFOPj2_jhKXJc0@z>

Commit 61562f981e92 ("uapi: export all arch specifics directories")
changed the dst from asm-<arch> to arch-<arch> for headers_install_all
or headers_check_all.  Update the comment.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 06ef9947cf7c..ce5875628740 100644
--- a/Makefile
+++ b/Makefile
@@ -1133,7 +1133,7 @@ firmware_install:
 #Default location for installed headers
 export INSTALL_HDR_PATH = $(objtree)/usr
 
-# If we do an all arch process set dst to asm-$(hdr-arch)
+# If we do an all arch process set dst to include/arch-$(hdr-arch)
 hdr-dst = $(if $(KBUILD_HEADERS), dst=include/arch-$(hdr-arch), dst=include)
 
 PHONY += archheaders
-- 
2.7.4
