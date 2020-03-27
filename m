From: John Garry <john.garry@huawei.com>
Subject: [PATCH v2 3/3] logic_pio: Use _inX() and _outX()
Date: Sat, 28 Mar 2020 00:06:14 +0800
Message-ID: <1585325174-195915-4-git-send-email-john.garry@huawei.com>
References: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:12203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbgC0QKd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Mar 2020 12:10:33 -0400
In-Reply-To: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: xuwei5@huawei.com, arnd@arndb.de
Cc: okaya@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, olof@lixom.net, jiaxun.yang@flygoat.com, John Garry <john.garry@huawei.com>

Use _inX() and _outX(), which include memory barriers which may be
overridden per arch.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 21dc731bec88..f32fe481b492 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -235,7 +235,7 @@ type logic_in##bwl(unsigned long addr)					\
 	type ret = (type)~0;						\
 									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		ret = read##bwl(PCI_IOBASE + addr);			\
+		ret = _in##bwl(addr);					\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -251,7 +251,7 @@ type logic_in##bwl(unsigned long addr)					\
 void logic_out##bwl(type value, unsigned long addr)			\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		write##bwl(value, PCI_IOBASE + addr);			\
+		_out##bwl(value, addr);				\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-- 
2.16.4
