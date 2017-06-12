From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 02/27] kbuild: fix comment about dst of headers_{install,check}_all
Date: Mon, 12 Jun 2017 12:26:56 +0900
Message-ID: <1497238041-7011-3-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:63932 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbdFLD2G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Jun 2017 23:28:06 -0400
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org

Commit 61562f981e92 ("uapi: export all arch specifics directories")
changed the dst from asm-<arch> to arch-<arch> for headers_install_all
or headers_check_all.  Update the comment.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 63e10bd4f14a..298a096863a9 100644
--- a/Makefile
+++ b/Makefile
@@ -1141,7 +1141,7 @@ firmware_install:
 #Default location for installed headers
 export INSTALL_HDR_PATH = $(objtree)/usr
 
-# If we do an all arch process set dst to asm-$(hdr-arch)
+# If we do an all arch process set dst to include/arch-$(hdr-arch)
 hdr-dst = $(if $(KBUILD_HEADERS), dst=include/arch-$(hdr-arch), dst=include)
 
 PHONY += archheaders
-- 
2.7.4
