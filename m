From: John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] logic_pio: Use _inX() and _outX()
Date: Wed, 18 Mar 2020 23:55:35 +0800
Message-ID: <1584546935-75393-4-git-send-email-john.garry@huawei.com>
References: <1584546935-75393-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1584546935-75393-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xuwei5@huawei.com, arnd@arndb.de
Cc: okaya@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, olof@lixom.net, jiaxun.yang@flygoat.com, John Garry <john.garry@huawei.com>
List-Id: linux-arch.vger.kernel.org

Use _inX() and _outX(), which include memory barriers which may be
overridden per arch.

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
2.12.3
