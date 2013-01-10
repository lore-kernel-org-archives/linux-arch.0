From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v3 01/44] asm-generic/io.h: check CONFIG_VIRT_TO_BUS
Date: Thu, 10 Jan 2013 15:30:29 +0000
Message-ID: <1357831872-29451-2-git-send-email-james.hogan@imgtec.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>
List-Id: linux-arch.vger.kernel.org

Make asm-generic/io.h check CONFIG_VIRT_TO_BUS before defining
virt_to_bus() and bus_to_virt(), otherwise it's easy to accidentally
have a silently failing incorrect direct mapped definition rather then
no definition at all.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/io.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 8e260cf..6b58e23 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -346,6 +346,7 @@ extern void ioport_unmap(void __iomem *p);
 #define xlate_dev_kmem_ptr(p)	p
 #define xlate_dev_mem_ptr(p)	__va(p)
 
+#ifdef CONFIG_VIRT_TO_BUS
 #ifndef virt_to_bus
 static inline unsigned long virt_to_bus(volatile void *address)
 {
@@ -357,6 +358,7 @@ static inline void *bus_to_virt(unsigned long address)
 	return (void *) address;
 }
 #endif
+#endif
 
 #ifndef memset_io
 #define memset_io(a, b, c)	memset(__io_virt(a), (b), (c))
-- 
1.7.7.6
