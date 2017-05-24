From: Babu Moger <babu.moger@oracle.com>
Subject: [PATCH v4 4/7] arch/sparc: Introduce cmpxchg_u8 SPARC
Date: Wed, 24 May 2017 17:55:12 -0600
Message-ID: <1495670115-63960-5-git-send-email-babu.moger@oracle.com>
References: <1495670115-63960-1-git-send-email-babu.moger@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495670115-63960-1-git-send-email-babu.moger@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, davem@davemloft.net
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com
List-Id: linux-arch.vger.kernel.org

SPARC supports 32 bit and 64 bit cmpxchg right now. Add support
for 8 bit (1 byte) cmpxchg. This is required to support queued
rwlocks feature  which uses 1 byte cmpxchg.

The function __cmpxchg_u8 here uses the 4 byte cas instruction with a
byte manipulation to achieve 1 byte cmpxchg.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/include/asm/cmpxchg_64.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index faa2f61..000f7d7 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -87,6 +87,33 @@ static inline unsigned long __xchg(unsigned long x, __volatile__ void * ptr,
 	return new;
 }
 
+/*
+ * Use 4 byte cas instruction to achieve 1 byte cmpxchg. Main logic
+ * here is to get the bit shift of the byte we are interested in.
+ * The XOR is handy for reversing the bits for big-endian byte order
+ */
+static inline unsigned long
+__cmpxchg_u8(volatile unsigned char *m, unsigned char old, unsigned char new)
+{
+	unsigned long maddr = (unsigned long)m;
+	int bit_shift = (((unsigned long)m & 3) ^ 3) << 3;
+	unsigned int mask = 0xff << bit_shift;
+	unsigned int *ptr = (unsigned int *) (maddr & ~3);
+	unsigned int old32, new32, load;
+	unsigned int load32 = *ptr;
+
+	do {
+		new32 = (load32 & ~mask) | (new << bit_shift);
+		old32 = (load32 & ~mask) | (old << bit_shift);
+		load32 = __cmpxchg_u32(ptr, old32, new32);
+		if (load32 == old32)
+			return old;
+		load = (load32 & mask) >> bit_shift;
+	} while (load == old);
+
+	return load;
+}
+
 /* This function doesn't exist, so you'll get a linker error
    if something tries to do an invalid cmpxchg().  */
 void __cmpxchg_called_with_bad_pointer(void);
@@ -95,6 +122,8 @@ static inline unsigned long __xchg(unsigned long x, __volatile__ void * ptr,
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
+		case 1:
+			return __cmpxchg_u8(ptr, old, new);
 		case 4:
 			return __cmpxchg_u32(ptr, old, new);
 		case 8:
-- 
1.7.1
