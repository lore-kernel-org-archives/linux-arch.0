From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch 2/3] tile: remove duplicate CONFIG_HOTPLUG definition
Date: Tue,  4 Sep 2012 17:01:07 -0700
Message-ID: <20120904235155.138994400@clark.kroah.org>
References: <20120904234803.554552301@clark.kroah.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50069 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab2IEAHV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2012 20:07:21 -0400
Received: by dady13 with SMTP id y13so4741898dad.19
        for <linux-arch@vger.kernel.org>; Tue, 04 Sep 2012 17:07:21 -0700 (PDT)
In-Reply-To: <20120904234803.554552301@clark.kroah.org>
Content-Disposition: inline; filename=tile-remove-duplicate-config_hotplug-definition.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Zankel <chris@zankel.net>

From: Greg KH <gregkh@linuxfoundation.org>

As part of the plan to remove CONFIG_HOTPLUG, it was found that tile
duplicates this config option for no reason (it's already defined as part of
init/Kconfig).  This patch removes it from the tile-only Kconfig file.

Cc: Chris Metcalf <cmetcalf@tilera.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/tile/Kconfig |    8 --------
 1 file changed, 8 deletions(-)

--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -412,14 +412,6 @@ config TILE_USB
 config NEED_BOUNCE_POOL
 	def_bool USB_OHCI_HCD
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-	  One well-known example of this is USB.
-
 source "drivers/pci/hotplug/Kconfig"
 
 endmenu
