From: Mark Salter <msalter@redhat.com>
Subject: [PATCH] C6X: change main arch kbuild symbol
Date: Mon, 23 Apr 2012 10:55:56 -0400
Message-ID: <1335192956-15753-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35072 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab2DWO4O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Apr 2012 10:56:14 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Mike Frysinger <vapier.adi@gmail.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Mark Salter <msalter@redhat.com>

Currently the c6x architecture uses CONFIG_TMS320C6X as the main
architecture symbol. Most architectures use a more intuitive name
based on the architecture directory name. There are no current
users of TMS320C6X so this patch simply changes CONFIG_TMS320C6X
to the more intuitive CONFIG_C6X.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/c6x/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 26e67f0..66a05fd 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -3,7 +3,7 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
-config TMS320C6X
+config C6X
 	def_bool y
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_SHOW
-- 
1.7.9.1
