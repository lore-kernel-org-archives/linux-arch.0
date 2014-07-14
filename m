From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 34/38] tile: clean-up uapi Kbuild file
Date: Mon, 14 Jul 2014 17:09:02 +0200
Message-ID: <1405350546-28467-34-git-send-email-sam@ravnborg.org>
References: <20140714150609.GA28358@ravnborg.org>
 <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:48472 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104AbaGNPJf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jul 2014 11:09:35 -0400
In-Reply-To: <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Chris Metcalf <cmetcalf@tilera.com>

Remove redundant assignments.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/tile/include/uapi/asm/Kbuild | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/tile/include/uapi/asm/Kbuild b/arch/tile/include/uapi/asm/Kbuild
index c20db8e..87d40be 100644
--- a/arch/tile/include/uapi/asm/Kbuild
+++ b/arch/tile/include/uapi/asm/Kbuild
@@ -1,21 +1,9 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-header-y += auxvec.h
-header-y += bitsperlong.h
-header-y += byteorder.h
 header-y += cachectl.h
 header-y += hardwall.h
-header-y += kvm_para.h
-header-y += mman.h
-header-y += ptrace.h
-header-y += setup.h
-header-y += sigcontext.h
-header-y += siginfo.h
-header-y += signal.h
-header-y += stat.h
-header-y += swab.h
 header-y += ucontext.h
-header-y += unistd.h
 
+# Wrapper from asm-generic
 generic-y += ucontext.h
-- 
1.9.3
