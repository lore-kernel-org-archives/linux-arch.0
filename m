From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] asm-generic: list Arnd as asm-generic maintainer
Date: Sun, 14 Jun 2009 22:53:35 +0200
Message-ID: <200906142253.35550.arnd@arndb.de>
References: <200906112146.32441.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60497 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbZFNUxi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 14 Jun 2009 16:53:38 -0400
In-Reply-To: <200906112146.32441.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Joe Perches <joe@perches.com>

I've modified about half the code in include/asm-generic now, and
people start sending me patches for it, so I should probably take
the formal responsibility for it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

I've already added this patch to my asm-generic tree and plan to push it
along with the patches I got from Mike Frysinger.

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f8128..f35f12e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2436,6 +2436,14 @@ F:	drivers/net/wan/pc300too.c
 F:	drivers/net/wan/pci200syn.c
 F:	drivers/net/wan/wanxl*
 
+GENERIC INCLUDE/ASM HEADER FILES
+P:	Arnd Bergmann
+M:	arnd@arndb.de
+L:	linux-arch@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
+S:	Maintained
+F:	include/asm-generic
+
 GFS2 FILE SYSTEM
 P:	Steven Whitehouse
 M:	swhiteho@redhat.com
-- 
1.6.3.1
