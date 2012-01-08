Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50774 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754492Ab2AHUsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 8 Jan 2012 15:48:46 -0500
Message-ID: <1326055714.13595.309.camel@deadeye>
Subject: [PATCH 1/2] topology: Check for missing CPU devices
From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 08 Jan 2012 20:48:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Thorsten Glaser <tg@mirbsd.de>, Debian kernel team <debian-kernel@lists.debian.org>, linux-m68k@vger.kernel.org, debian-68k@lists.debian.org
Message-ID: <20120108204834.zldwS8sE6aCztiJe1k-nSBwg5it17e581UVzchVU40U@z>

Commit ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b ('topology: Provide
CPU topology in sysfs in !SMP configurations') causes a crash at boot
on a several architectures.  The topology sysfs code assumes that
there is a CPU device for each online CPU whereas some architectures
that do not support SMP or cpufreq do not register any CPU devices.
Check for this before trying to use a device.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/base/topology.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index ae989c5..4467c85 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -147,6 +147,8 @@ static int __cpuinit topology_add_dev(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
+	if (!dev)
+		return -ENODEV;
 	return sysfs_create_group(&dev->kobj, &topology_attr_group);
 }
 
@@ -154,7 +156,8 @@ static void __cpuinit topology_remove_dev(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
-	sysfs_remove_group(&dev->kobj, &topology_attr_group);
+	if (dev)
+		sysfs_remove_group(&dev->kobj, &topology_attr_group);
 }
 
 static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
-- 
1.7.8.2



