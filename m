From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch 3/3] CONFIG_HOTPLUG should be always on
Date: Tue,  4 Sep 2012 17:01:08 -0700
Message-ID: <20120904235155.218456468@clark.kroah.org>
References: <20120904234803.554552301@clark.kroah.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65016 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758015Ab2IEABl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2012 20:01:41 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4738848dad.19
        for <linux-arch@vger.kernel.org>; Tue, 04 Sep 2012 17:01:41 -0700 (PDT)
In-Reply-To: <20120904234803.554552301@clark.kroah.org>
Content-Disposition: inline; filename=config_hotplug-should-be-always-on.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>

From: Greg KH <gregkh@linuxfoundation.org>

CONFIG_HOTPLUG is a very old option, back when we had static systems and it was
odd that any type of device would be removed or added after the system had
started up.  It is quite hard to disable it these days, and even if you do, it
only saves you about 200 bytes.  However, if it is disabled, lots of bugs show
up because it is almost never tested if the option is disabled.

This is a step to eventually just remove the option entirely, which will clean
up all of the devinit* variable and function pointer options, that everyone
(myself include) ends up getting wrong eventually, causing real problems when
memory segments are removed yet we don't expect them to be.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>

---
 init/Kconfig |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1201,13 +1201,7 @@ config KALLSYMS_ALL
 	   Say N unless you really need all symbols.
 
 config HOTPLUG
-	bool "Support for hot-pluggable devices" if EXPERT
-	default y
-	help
-	  This option is provided for the case where no hotplug or uevent
-	  capabilities is wanted by the kernel.  You should only consider
-	  disabling this option for embedded systems that do not use modules, a
-	  dynamic /dev tree, or dynamic device discovery.  Just say Y.
+	def_bool y
 
 config PRINTK
 	default y
