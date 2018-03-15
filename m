Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:19904
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751869AbeCOLCW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 07:02:22 -0400
From: Aaron Wu <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 28/28] MAINTAINERS: Remove Blackfin from MAINTAINERS list
Date: Thu, 15 Mar 2018 18:50:28 +0800
Message-ID: <1521111028-19856-28-git-send-email-aaron.wu@analog.com>
In-Reply-To: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, f.fainelli@gmail.com, linux-arch@vger.kernel.org, kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, liqin.linux@gmail.com, lennox.wu@gmail.com, gxt@mprc.pku.edu.cn, linux@roeck-us.net
Cc: viro@zeniv.linux.org.uk, jhogan@kernel.org, linux-metag@vger.kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, openrisc@lists.librecores.org, dhowells@redhat.com, peterz@infradead.org, aaron.wu@analog.com

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin from MAINTAINERS list
---
 MAINTAINERS | 52 ----------------------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf..f5a0857 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -841,13 +841,6 @@ F:	sound/soc/codecs/ad7*
 F:	sound/soc/codecs/ssm*
 F:	sound/soc/codecs/sigmadsp.*
 
-ANALOG DEVICES INC ASOC DRIVERS
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org/
-S:	Supported
-F:	sound/soc/blackfin/*
-
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 W:	http://ez.analog.com/community/linux-device-drivers
@@ -2629,51 +2622,6 @@ F:	Documentation/filesystems/bfs.txt
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
-BLACKFIN ARCHITECTURE
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-T:	git git://git.code.sf.net/p/adi-linux/code
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	arch/blackfin/
-
-BLACKFIN EMAC DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/net/ethernet/adi/
-
-BLACKFIN MEDIA DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org/
-S:	Orphan
-F:	drivers/media/platform/blackfin/
-F:	drivers/media/i2c/adv7183*
-F:	drivers/media/i2c/vs6624*
-
-BLACKFIN RTC DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/rtc/rtc-bfin.c
-
-BLACKFIN SDH DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/mmc/host/bfin_sdh.c
-
-BLACKFIN SERIAL DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/tty/serial/bfin_uart.c
-
-BLACKFIN WATCHDOG DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/watchdog/bfin_wdt.c
-
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
-- 
2.7.4
