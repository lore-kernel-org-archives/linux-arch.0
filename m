From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 33/40] parport: don't build on METAG
Date: Wed, 31 Oct 2012 16:14:14 +0000
Message-ID: <1351700061-7203-34-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49759 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423213Ab2JaQP3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:15:29 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

The metag architecture port doesn't support PC parallel ports, so add
METAG to the list of architectures not to build it's driver on.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 drivers/parport/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index d92185a..474facb 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -36,7 +36,7 @@ if PARPORT
 config PARPORT_PC
 	tristate "PC-style hardware"
 	depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
-		(!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
+		(!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN && !METAG
 	---help---
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
-- 
1.7.7.6
