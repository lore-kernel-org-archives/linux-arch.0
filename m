From: John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/3] logic_pio: Improve macro argument name
Date: Sat, 28 Mar 2020 00:06:13 +0800
Message-ID: <1585325174-195915-3-git-send-email-john.garry@huawei.com>
References: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:12202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbgC0QKc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Mar 2020 12:10:32 -0400
In-Reply-To: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: xuwei5@huawei.com, arnd@arndb.de
Cc: okaya@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, olof@lixom.net, jiaxun.yang@flygoat.com, John Garry <john.garry@huawei.com>

Macro argument "bw" is used for building byte, word, and long-based
functions. Use "bwl" instead, to include long.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index f511a99bb389..21dc731bec88 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -229,13 +229,13 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 }
 
 #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
-#define BUILD_LOGIC_IO(bw, type)					\
-type logic_in##bw(unsigned long addr)					\
+#define BUILD_LOGIC_IO(bwl, type)					\
+type logic_in##bwl(unsigned long addr)					\
 {									\
 	type ret = (type)~0;						\
 									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		ret = read##bw(PCI_IOBASE + addr);			\
+		ret = read##bwl(PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -248,10 +248,10 @@ type logic_in##bw(unsigned long addr)					\
 	return ret;							\
 }									\
 									\
-void logic_out##bw(type value, unsigned long addr)			\
+void logic_out##bwl(type value, unsigned long addr)			\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		write##bw(value, PCI_IOBASE + addr);			\
+		write##bwl(value, PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -263,11 +263,11 @@ void logic_out##bw(type value, unsigned long addr)			\
 	}								\
 }									\
 									\
-void logic_ins##bw(unsigned long addr, void *buffer,			\
-		   unsigned int count)					\
+void logic_ins##bwl(unsigned long addr, void *buffer,			\
+		    unsigned int count)					\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+		reads##bwl(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -280,11 +280,11 @@ void logic_ins##bw(unsigned long addr, void *buffer,			\
 									\
 }									\
 									\
-void logic_outs##bw(unsigned long addr, const void *buffer,		\
-		    unsigned int count)					\
+void logic_outs##bwl(unsigned long addr, const void *buffer,		\
+		     unsigned int count)				\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		writes##bw(PCI_IOBASE + addr, buffer, count);		\
+		writes##bwl(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-- 
2.16.4
