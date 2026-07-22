Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5810D47278D;
	Wed, 22 Jul 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734257; cv=none; b=A7XnHtL4cxvohVgi+ED3i8dtV88Uiv9OpEvasBZZgaLBEUruKRQLjOi6zbQqWwDGsXY3vS9xUxuj1b2rUMOw/BQuMvV3OrGoKVe8kchTB61PHGDt6LxUVCpdeDYwwYcEKcWjJ7q2rkja89MxF/ptM3vBttJ5kZesqYKANBHuqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734257; c=relaxed/simple;
	bh=NwLzJE9YUYcwQouyyHhdNDainQ0wboh6oH5R8Qr5IHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZSDNRx1bUBDv02mxJVkuLZvkNpdrQXxVDkwAkKkjMqqlsqNfc7HDzhc8L/YYx2SA4ZdAoz3EYcf7DCopXsJ/WUPqQ3O7gQj9+cmEKdKUowuOGE63riDNc7f8XGGaxRtidChJ3uBCFV4w3te2P1Sp5VKtT5xvQGLYA+bQK1Pv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CMfDyJKB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CMfDyJKB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 914D81595;
	Wed, 22 Jul 2026 08:30:50 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEB983F66F;
	Wed, 22 Jul 2026 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734254; bh=NwLzJE9YUYcwQouyyHhdNDainQ0wboh6oH5R8Qr5IHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CMfDyJKBKmK50YTcejppNKTrTWiJP57IF6DHVLjdYdB2gqyRXO1180hCz77V7dhiw
	 /Rhc6XGpzTsM9UJ2o8cGBXNsPlK7hInWAm0H7N+W5Ya7RehIy81zPyYAERNZ20t24L
	 nfvmJqhMmxi974lDKs5uoKjcVHSlsRqupqgSxxk0=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:10 +0100
Subject: [PATCH RFC v2 02/20] ARM: mm: make 2-level pgd_t a scalar
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-2-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
In-Reply-To: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
To: Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-openrisc@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2168; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=3A02R9gJAFlGYYgA2zmEeHAxV0ZhWViB/KSchyi5T/4=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIQeAF4NvX+ghiLdlZcQA9dzdnJsUpGO89IJ
 Z0P4tNZzvGJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiEAAKCRBt1cPRWsUx
 M9cgDACmrJH7vGtwlt1q+G75J+q2g7DLACRd8qQ65REy5KW9VbVYXXmBfsv7k2aacinnF+IUr1m
 w3DvIXTMScFAlv6aZMEIqzXU9KuPuo24JNo8rMNKxi9T1m+acBCRHvLvSO2xL29IrbZAcioI4Wx
 p65yuAc9KS13mOJr3OIKeTM2uPBpc+Dm5DZte59tUdL88pUcKmgr5jOzWyXYdMRsz3hDwLYMW+2
 xxjo5fmXJlXgap750FaoM8rT0iXoAT6YJTKSXBHneNtHjfELNOmnfR3FouecTJpQYreibBoY4Go
 wTzx/VMNWooLYFE7j0Suwe4IRqREcwTjIE7Sy0K+4hH8myO5maXRxcC6QsnckrWLVBUFmQB4lFH
 /yAaiETHizvEjofTsL+JjwiTrmaQq2gXigwhquNdb6UYzqGvR7neA73xa7ugREzMT8ojGHpTpOr
 l75oD4xe0+GWpdz7MWMp3Wqtq2t9VjFSsaVZperSbQsuUsnnV9f1oO35vpoX6HoDyNfd4=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

We don't want pgd_t to be an array, as it prohibits returning it from a
function, like pgdp_get().

So let's just use an u64, and extract the right 32bit value in
pgd_val().

Leave the STRICT_MM_TYPECHECKS case alone for now.

As an alternative, we could use the STRICT_MM_TYPECHECKS approach here
as well, but using an u64 looks conceptually cleaner, even though
pgd_val() gets a bit more involved.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/arm/include/asm/pgtable-2level-types.h | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level-types.h b/arch/arm/include/asm/pgtable-2level-types.h
index 650e793f4142..7f85384ac386 100644
--- a/arch/arm/include/asm/pgtable-2level-types.h
+++ b/arch/arm/include/asm/pgtable-2level-types.h
@@ -25,7 +25,7 @@ typedef struct { pteval_t pgprot; } pgprot_t;
 
 #define pte_val(x)      ((x).pte)
 #define pmd_val(x)      ((x).pmd)
-#define pgd_val(x)	((x).pgd[0])
+#define pgd_val(x)      ((x).pgd[0])
 #define pgprot_val(x)   ((x).pgprot)
 
 #define __pte(x)        ((pte_t) { (x) } )
@@ -36,14 +36,32 @@ typedef struct { pteval_t pgprot; } pgprot_t;
 /*
  * .. while these make it easier on the compiler
  */
+typedef u64 pgdval_t;
+
 typedef pteval_t pte_t;
 typedef pmdval_t pmd_t;
-typedef pmdval_t pgd_t[2];
+typedef pgdval_t pgd_t;
 typedef pteval_t pgprot_t;
 
 #define pte_val(x)      (x)
 #define pmd_val(x)      (x)
-#define pgd_val(x)	((x)[0])
+
+static inline pmdval_t pgd_val(pgd_t pgd)
+{
+	/*
+	 * The lower and higher pmdval_t values point to the same page.
+	 * the only difference is their offset within that page.
+	 * Therefore, whichever value is returned, the behavior of pmd_pfn(),
+	 * pmd_page(), and other users of pgd_val() remains unchanged.
+	 *
+	 * However, pgd_val() has historically returned the lower pmdval_t, so
+	 * keep returning the lower one.
+	 *
+	 * See the comments in include/asm/pgtable-2level.
+	 */
+	return (*(pmdval_t (*)[2])&pgd)[0];
+}
+
 #define pgprot_val(x)   (x)
 
 #define __pte(x)        (x)

-- 
2.43.0

