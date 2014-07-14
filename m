From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 15/38] blackfin: clean-up uapi Kbuild file
Date: Mon, 14 Jul 2014 17:08:43 +0200
Message-ID: <1405350546-28467-15-git-send-email-sam@ravnborg.org>
References: <20140714150609.GA28358@ravnborg.org>
 <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:48472 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbaGNPJ0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jul 2014 11:09:26 -0400
In-Reply-To: <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Steven Miao <realmz6@gmail.com>

Remove redundant assignments.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Steven Miao <realmz6@gmail.com>
---
 arch/blackfin/include/uapi/asm/Kbuild | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/blackfin/include/uapi/asm/Kbuild b/arch/blackfin/include/uapi/asm/Kbuild
index 0bd28f7..c226f31 100644
--- a/arch/blackfin/include/uapi/asm/Kbuild
+++ b/arch/blackfin/include/uapi/asm/Kbuild
@@ -2,18 +2,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 header-y += bfin_sport.h
-header-y += byteorder.h
 header-y += cachectl.h
-header-y += fcntl.h
 header-y += fixed_code.h
-header-y += ioctls.h
-header-y += kvm_para.h
-header-y += poll.h
-header-y += posix_types.h
-header-y += ptrace.h
-header-y += sigcontext.h
-header-y += siginfo.h
-header-y += signal.h
-header-y += stat.h
-header-y += swab.h
-header-y += unistd.h
-- 
1.9.3
