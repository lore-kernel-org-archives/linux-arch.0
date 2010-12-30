Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9754 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0L3ECt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Dec 2010 23:02:49 -0500
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id oBU42mSI024664
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:48 -0800
Received: from pzk34 (pzk34.prod.google.com [10.243.19.162])
	by hpaq14.eem.corp.google.com with ESMTP id oBU42jGQ018804
	for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:46 -0800
Received: by pzk34 with SMTP id 34so2697570pzk.38
        for <linux-arch@vger.kernel.org>; Wed, 29 Dec 2010 20:02:45 -0800 (PST)
Date: Wed, 29 Dec 2010 20:02:43 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: [patch 4/8] fs: rename CONFIG_EMBEDDED to CONFIG_EXPERT
In-Reply-To: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.00.1012292000460.27241@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1012291959200.27241@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20101230040243.MC9-V24j5jB8K10aXCS9k6LcMXDvdH3H-2FwRYT1dSI@z>

CONFIG_EMBEDDED has been renamed to CONFIG_EXPERT, so fix it in the fs/
directory.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 fs/Kconfig       |    2 +-
 fs/proc/Kconfig  |    6 +++---
 fs/sysfs/Kconfig |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -51,7 +51,7 @@ config EXPORTFS
 	tristate
 
 config FILE_LOCKING
-	bool "Enable POSIX file locking API" if EMBEDDED
+	bool "Enable POSIX file locking API" if EXPERT
 	default y
 	help
 	  This option enables standard file locking support, required
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -1,5 +1,5 @@
 config PROC_FS
-	bool "/proc file system support" if EMBEDDED
+	bool "/proc file system support" if EXPERT
 	default y
 	help
 	  This is a virtual file system providing information about the status
@@ -40,7 +40,7 @@ config PROC_VMCORE
         Exports the dump image of crashed kernel in ELF format.
 
 config PROC_SYSCTL
-	bool "Sysctl support (/proc/sys)" if EMBEDDED
+	bool "Sysctl support (/proc/sys)" if EXPERT
 	depends on PROC_FS
 	select SYSCTL
 	default y
@@ -61,7 +61,7 @@ config PROC_SYSCTL
 config PROC_PAGE_MONITOR
  	default y
 	depends on PROC_FS && MMU
-	bool "Enable /proc page monitoring" if EMBEDDED
+	bool "Enable /proc page monitoring" if EXPERT
  	help
 	  Various /proc files exist to monitor process memory utilization:
 	  /proc/pid/smaps, /proc/pid/clear_refs, /proc/pid/pagemap,
diff --git a/fs/sysfs/Kconfig b/fs/sysfs/Kconfig
--- a/fs/sysfs/Kconfig
+++ b/fs/sysfs/Kconfig
@@ -1,5 +1,5 @@
 config SYSFS
-	bool "sysfs file system support" if EMBEDDED
+	bool "sysfs file system support" if EXPERT
 	default y
 	help
 	The sysfs filesystem is a virtual filesystem that the kernel uses to
