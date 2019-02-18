Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37059 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfBRKya (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 05:54:30 -0500
Date: Mon, 18 Feb 2019 11:54:27 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: [PATCH 3/4] io: change io*_rep definitions to take ulong count
Message-ID: <2162a4ee6b1fe781853a75c45d38f73d042d2bc9.1550485787.git.hle@owl.eu.com>
References: <cover.1550485787.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550485787.git.hle@owl.eu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190218105427.Uv3UZ105XcdQSKo65pNtfKxHHjvxTxUmsNzLoHJf4Cs@z>

ioread*_rep and iowrite*_rep from asm-generic/io.h expect unsigned
int count parameter. This is inconsistent with all other definitions
in the kernel which take unsigned long count.

Change io*_rep definitions to take unsigned long count instead of
unsigned int.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 include/asm-generic/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d356f802945a..345ae6a09bca 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -811,7 +811,7 @@ static inline void iowrite64be(u64 value, volatile void __iomem *addr)
 #ifndef ioread8_rep
 #define ioread8_rep ioread8_rep
 static inline void ioread8_rep(const volatile void __iomem *addr, void *buffer,
-			       unsigned int count)
+			       unsigned long count)
 {
 	readsb(addr, buffer, count);
 }
@@ -820,7 +820,7 @@ static inline void ioread8_rep(const volatile void __iomem *addr, void *buffer,
 #ifndef ioread16_rep
 #define ioread16_rep ioread16_rep
 static inline void ioread16_rep(const volatile void __iomem *addr,
-				void *buffer, unsigned int count)
+				void *buffer, unsigned long count)
 {
 	readsw(addr, buffer, count);
 }
@@ -829,7 +829,7 @@ static inline void ioread16_rep(const volatile void __iomem *addr,
 #ifndef ioread32_rep
 #define ioread32_rep ioread32_rep
 static inline void ioread32_rep(const volatile void __iomem *addr,
-				void *buffer, unsigned int count)
+				void *buffer, unsigned long count)
 {
 	readsl(addr, buffer, count);
 }
@@ -839,7 +839,7 @@ static inline void ioread32_rep(const volatile void __iomem *addr,
 #ifndef ioread64_rep
 #define ioread64_rep ioread64_rep
 static inline void ioread64_rep(const volatile void __iomem *addr,
-				void *buffer, unsigned int count)
+				void *buffer, unsigned long count)
 {
 	readsq(addr, buffer, count);
 }
@@ -850,7 +850,7 @@ static inline void ioread64_rep(const volatile void __iomem *addr,
 #define iowrite8_rep iowrite8_rep
 static inline void iowrite8_rep(volatile void __iomem *addr,
 				const void *buffer,
-				unsigned int count)
+				unsigned long count)
 {
 	writesb(addr, buffer, count);
 }
@@ -860,7 +860,7 @@ static inline void iowrite8_rep(volatile void __iomem *addr,
 #define iowrite16_rep iowrite16_rep
 static inline void iowrite16_rep(volatile void __iomem *addr,
 				 const void *buffer,
-				 unsigned int count)
+				 unsigned long count)
 {
 	writesw(addr, buffer, count);
 }
@@ -870,7 +870,7 @@ static inline void iowrite16_rep(volatile void __iomem *addr,
 #define iowrite32_rep iowrite32_rep
 static inline void iowrite32_rep(volatile void __iomem *addr,
 				 const void *buffer,
-				 unsigned int count)
+				 unsigned long count)
 {
 	writesl(addr, buffer, count);
 }
@@ -881,7 +881,7 @@ static inline void iowrite32_rep(volatile void __iomem *addr,
 #define iowrite64_rep iowrite64_rep
 static inline void iowrite64_rep(volatile void __iomem *addr,
 				 const void *buffer,
-				 unsigned int count)
+				 unsigned long count)
 {
 	writesq(addr, buffer, count);
 }
-- 
2.20.1
