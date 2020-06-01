Return-Path: <SRS0=za/P=7O=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v4 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Date: Mon, 1 Jun 2020 22:47:13 +0800
Message-ID: <20200601144713.2222-3-yezhenyu2@huawei.com>
In-Reply-To: <20200601144713.2222-1-yezhenyu2@huawei.com>
References: <20200601144713.2222-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200601144713.N-QntJReNuXATmpFfKUnajWVSMwlp5R8b0f0Gpy8JII@z>

Add __TLBI_VADDR_RANGE macro and rewrite __flush_tlb_range().

In this patch, we only use the TLBI RANGE feature if the stride =3D=3D PA=
GE_SIZE,
because when stride > PAGE_SIZE, usually only a small number of pages nee=
d
to be flushed and classic tlbi intructions are more effective.

We can also use 'end - start < threshold number' to decide which way
to go, however, different hardware may have different thresholds, so
I'm not sure if this is feasible.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlbflush.h | 98 +++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/t=
lbflush.h
index bc3949064725..818f27c82024 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -50,6 +50,16 @@
 		__tlbi(op, (arg) | USER_ASID_FLAG);				\
 } while (0)
=20
+#define __tlbi_last_level(op1, op2, arg, last_level) do {		\
+	if (last_level)	{						\
+		__tlbi(op1, arg);					\
+		__tlbi_user(op1, arg);					\
+	} else {							\
+		__tlbi(op2, arg);					\
+		__tlbi_user(op2, arg);					\
+	}								\
+} while (0)
+
 /* This macro creates a properly formatted VA operand for the TLBI */
 #define __TLBI_VADDR(addr, asid)				\
 	({							\
@@ -59,6 +69,47 @@
 		__ta;						\
 	})
=20
+/*
+ * __TG defines translation granule of the system, which is decided by
+ * PAGE_SHIFT.  Used by TTL.
+ *  - 4KB	: 1
+ *  - 16KB	: 2
+ *  - 64KB	: 3
+ */
+#define __TG	((PAGE_SHIFT - 12) / 2 + 1)
+
+/*
+ * This macro creates a properly formatted VA operand for the TLBI RANGE=
.
+ * The value bit assignments are:
+ *
+ * +----------+------+-------+-------+-------+----------------------+
+ * |   ASID   |  TG  | SCALE |  NUM  |  TTL  |        BADDR         |
+ * +-----------------+-------+-------+-------+----------------------+
+ * |63      48|47  46|45   44|43   39|38   37|36                   0|
+ *
+ * The address range is determined by below formula:
+ * [BADDR, BADDR + (NUM + 1) * 2^(5*SCALE + 1) * PAGESIZE)
+ *
+ */
+#define __TLBI_VADDR_RANGE(addr, asid, scale, num, ttl)		\
+	({							\
+		unsigned long __ta =3D (addr) >> PAGE_SHIFT;	\
+		__ta &=3D GENMASK_ULL(36, 0);			\
+		__ta |=3D (unsigned long)(ttl) << 37;		\
+		__ta |=3D (unsigned long)(num) << 39;		\
+		__ta |=3D (unsigned long)(scale) << 44;		\
+		__ta |=3D (unsigned long)(__TG) << 46;		\
+		__ta |=3D (unsigned long)(asid) << 48;		\
+		__ta;						\
+	})
+
+/* This macro defines the range pages of the TLBI RANGE. */
+#define __TLBI_RANGE_SIZES(num, scale)	((num + 1) << (5 * scale + 1) << =
PAGE_SHIFT)
+
+#define TLB_RANGE_MASK_SHIFT 5
+#define TLB_RANGE_MASK GENMASK_ULL(TLB_RANGE_MASK_SHIFT - 1, 0)
+
+
 /*
  *	TLB Invalidation
  *	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -181,32 +232,55 @@ static inline void __flush_tlb_range(struct vm_area=
_struct *vma,
 				     unsigned long start, unsigned long end,
 				     unsigned long stride, bool last_level)
 {
+	int num =3D 0;
+	int scale =3D 0;
 	unsigned long asid =3D ASID(vma->vm_mm);
 	unsigned long addr;
+	unsigned long range_pages;
=20
 	start =3D round_down(start, stride);
 	end =3D round_up(end, stride);
+	range_pages =3D (end - start) >> PAGE_SHIFT;
=20
 	if ((end - start) >=3D (MAX_TLBI_OPS * stride)) {
 		flush_tlb_mm(vma->vm_mm);
 		return;
 	}
=20
-	/* Convert the stride into units of 4k */
-	stride >>=3D 12;
+	dsb(ishst);
=20
-	start =3D __TLBI_VADDR(start, asid);
-	end =3D __TLBI_VADDR(end, asid);
+	/*
+	 * The minimum size of TLB RANGE is 2 pages;
+	 * Use normal TLB instruction to handle odd pages.
+	 * If the stride !=3D PAGE_SIZE, this will never happen.
+	 */
+	if (range_pages % 2 =3D=3D 1) {
+		addr =3D __TLBI_VADDR(start, asid);
+		__tlbi_last_level(vale1is, vae1is, addr, last_level);
+		start +=3D 1 << PAGE_SHIFT;
+		range_pages >>=3D 1;
+	}
=20
-	dsb(ishst);
-	for (addr =3D start; addr < end; addr +=3D stride) {
-		if (last_level) {
-			__tlbi(vale1is, addr);
-			__tlbi_user(vale1is, addr);
-		} else {
-			__tlbi(vae1is, addr);
-			__tlbi_user(vae1is, addr);
+	while (range_pages > 0) {
+		if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
+		    stride =3D=3D PAGE_SIZE) {
+			num =3D (range_pages & TLB_RANGE_MASK) - 1;
+			if (num >=3D 0) {
+				addr =3D __TLBI_VADDR_RANGE(start, asid, scale,
+							  num, 0);
+				__tlbi_last_level(rvale1is, rvae1is, addr,
+						  last_level);
+				start +=3D __TLBI_RANGE_SIZES(num, scale);
+			}
+			scale++;
+			range_pages >>=3D TLB_RANGE_MASK_SHIFT;
+			continue;
 		}
+
+		addr =3D __TLBI_VADDR(start, asid);
+		__tlbi_last_level(vale1is, vae1is, addr, last_level);
+		start +=3D stride;
+		range_pages -=3D stride >> 12;
 	}
 	dsb(ish);
 }
--=20
2.19.1
