From: David Rientjes <rientjes@google.com>
Subject: [patch 8/8] usr: rename CONFIG_EMBEDDED to CONFIG_EXPERT
Date: Wed, 29 Dec 2010 20:02:55 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1012292002040.27241@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:38185 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0L3EDA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Dec 2010 23:03:00 -0500
Received: from wpaz9.hot.corp.google.com (wpaz9.hot.corp.google.com [172.24.198.73])
	by smtp-out.google.com with ESMTP id oBU42xpP020018
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:03:00 -0800
Received: from pxi12 (pxi12.prod.google.com [10.243.27.12])
	by wpaz9.hot.corp.google.com with ESMTP id oBU42go0022230
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:58 -0800
Received: by pxi12 with SMTP id 12so2414716pxi.28
        for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

CONFIG_EMBEDDED has been renamed to CONFIG_EXPERT, so fix it in the usr/
directory.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 usr/Kconfig |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/usr/Kconfig b/usr/Kconfig
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -46,7 +46,7 @@ config INITRAMFS_ROOT_GID
 	  If you are not sure, leave it set to "0".
 
 config RD_GZIP
-	bool "Support initial ramdisks compressed using gzip" if EMBEDDED
+	bool "Support initial ramdisks compressed using gzip" if EXPERT
 	default y
 	depends on BLK_DEV_INITRD
 	select DECOMPRESS_GZIP
@@ -55,8 +55,8 @@ config RD_GZIP
 	  If unsure, say Y.
 
 config RD_BZIP2
-	bool "Support initial ramdisks compressed using bzip2" if EMBEDDED
-	default !EMBEDDED
+	bool "Support initial ramdisks compressed using bzip2" if EXPERT
+	default !EXPERT
 	depends on BLK_DEV_INITRD
 	select DECOMPRESS_BZIP2
 	help
@@ -64,8 +64,8 @@ config RD_BZIP2
 	  If unsure, say N.
 
 config RD_LZMA
-	bool "Support initial ramdisks compressed using LZMA" if EMBEDDED
-	default !EMBEDDED
+	bool "Support initial ramdisks compressed using LZMA" if EXPERT
+	default !EXPERT
 	depends on BLK_DEV_INITRD
 	select DECOMPRESS_LZMA
 	help
@@ -73,8 +73,8 @@ config RD_LZMA
 	  If unsure, say N.
 
 config RD_LZO
-	bool "Support initial ramdisks compressed using LZO" if EMBEDDED
-	default !EMBEDDED
+	bool "Support initial ramdisks compressed using LZO" if EXPERT
+	default !EXPERT
 	depends on BLK_DEV_INITRD
 	select DECOMPRESS_LZO
 	help
