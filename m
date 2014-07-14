From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 05/38] tile: clean up Kbuild files
Date: Mon, 14 Jul 2014 17:08:33 +0200
Message-ID: <1405350546-28467-5-git-send-email-sam@ravnborg.org>
References: <20140714150609.GA28358@ravnborg.org>
 <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:48404 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755949AbaGNPJU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jul 2014 11:09:20 -0400
In-Reply-To: <1405350546-28467-1-git-send-email-sam@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Chris Metcalf <cmetcalf@tilera.com>, David Howells <dhowells@redhat.com>

Drop an unused Kbuild file - it was anyway empty
Drop an irrelevent assignment to header-y

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: David Howells <dhowells@redhat.com>
---
 arch/tile/include/arch/Kbuild | 1 -
 arch/tile/include/asm/Kbuild  | 3 ---
 2 files changed, 4 deletions(-)
 delete mode 100644 arch/tile/include/arch/Kbuild

diff --git a/arch/tile/include/arch/Kbuild b/arch/tile/include/arch/Kbuild
deleted file mode 100644
index 3751c9f..0000000
--- a/arch/tile/include/arch/Kbuild
+++ /dev/null
@@ -1 +0,0 @@
-# Tile arch headers
diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index 0aa5675..3013a07 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -1,6 +1,3 @@
-
-header-y += ../arch/
-
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += clkdev.h
-- 
1.9.3
