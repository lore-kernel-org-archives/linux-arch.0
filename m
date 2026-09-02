Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A8747ECF4;
	Wed,  2 Sep 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350229; cv=none; b=VaJnq6QZM8ExXoehk9+knADomtRRZHeF+hvBkAxAGs3wLs1arHaiT9cTNBlyYUE7krb0apPE2jZy+6Xto2aZHcq05Tsuc56+3SmlOpe+/qOfGzufj8764SRcuRbsMOjiSkDuNvUt4hNmDPnooqNWRURmokxpHnbEKGery9vsn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350229; c=relaxed/simple;
	bh=gPlnE5UqZRk40YfWFz/1w9GlKcNlqtJOo/oAxLycbvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJAgBU+7O9nmS/VoCj7ISxDsJEPsZp8ugDXSR1XC3Mk7OXAAV7v+TqHON22kkisI3M4M4NiQBelgAUzSD0dCdvSpy29nJxSzgwRVHchILkxgsSMJ7ih5SIku8OWqEoWj2y35qqpbAgk7V2Xrhh3hQhhznA3lPQUita4D08COsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JngvOrh/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JngvOrh/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25B9F1E4D;
	Wed,  2 Sep 2026 04:56:47 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C29DA3F85F;
	Wed,  2 Sep 2026 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350210; bh=gPlnE5UqZRk40YfWFz/1w9GlKcNlqtJOo/oAxLycbvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JngvOrh/7RH2K28ggppoS4NPOaZa16P0lMCoxQdm8Y5sORQtjxmHS2nRWh7A+nD4U
	 lR6pGdNIo04IsFUKW5Iu2DeZy5RCXDzqAoufI7eiLPS9ULkCP3Objs0zsXamRb15xM
	 79g8rzGAvghuXLj6fzSyLmOEqrVRnC+EMjOuSpSI=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 02 Sep 2026 12:56:04 +0100
Subject: [PATCH RFC v3 02/21] ARM: mm: make 2-level pgd_t a scalar
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-dummy_ptxp3-v3-2-5d8f5b17c25c@arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
In-Reply-To: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=uhcO6NTPYBqTkI+U1pSNHYmMsIjTOQrElUAua45fg4s=;
 b=kA0DAAoBbdXD0VrFMTMByyZiAGqYDuKh4pUBsXDB1v/n9ZVHNsXgpbZHusYBh6IUK6klb7xYB
 YkBswQAAQoAHRYhBC2D4JLdBTO4WHWknW3Vw9FaxTEzBQJqmA7iAAoJEG3Vw9FaxTEz0BQL/2nk
 sf3h4xmh3cZtnS+lTvf+itMKAMxUvApGWmC4Wv39xE1jps4ZQyzWb/SJp98V66g00L30MWVLQgD
 tat6tOwX2/q+6qy17JKwUz/7i6TzD/TZzQ32xBFcvYhluUlq4Pz649NjIZ1uEl17UZziViJLQZo
 B644h4n9Wc3Fi0IzgaW+5KhHLWdt3ZRDR4WZpZi7IjFTFL9oWkZy+PhQQbx81hRv7nsS9YwgULP
 fPyvywMC5/BRNiJv4Bv2rw2drYfgLwbtkRYVXdzToW0jskEmlweWHUbj/LEfWkimMjxMWvghuAo
 Oeu5Ftb+6z/NoWkVWxtiZgTWcKlD6bqJRc4X95Ub5E3L9cgOVL/seXRA+oZwAczjdUHNqa91mAl
 pnh0MNHv3f/9NAQhLk8LtdSDcYIXBjJ6AbC+3whUFU8/q87D2oQ4K6sGHgvH6W2nYMjrBVc4by4
 tF8lhm2Doykt9IqmrtjwiMUDhbIJElBOahrbMYMCzbEgkFh+2nRz6QH8GanA==
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

As pgd_t is returned from a function like pgdp_get(), pgd_t shouldn't
be an array.

So, just use an u64, and extract the right 32bit value in pgd_val().

Leave the STRICT_MM_TYPECHECKS case alone for now.

As an alternative, the STRICT_MM_TYPECHECKS approach could be used here
as well, but using an u64 looks conceptually cleaner, even though
pgd_val() gets a bit more involved.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/arm/include/asm/pgtable-2level-types.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level-types.h b/arch/arm/include/asm/pgtable-2level-types.h
index 650e793f4142..805044ea315b 100644
--- a/arch/arm/include/asm/pgtable-2level-types.h
+++ b/arch/arm/include/asm/pgtable-2level-types.h
@@ -25,7 +25,7 @@ typedef struct { pteval_t pgprot; } pgprot_t;
 
 #define pte_val(x)      ((x).pte)
 #define pmd_val(x)      ((x).pmd)
-#define pgd_val(x)	((x).pgd[0])
+#define pgd_val(x)      ((x).pgd[0])
 #define pgprot_val(x)   ((x).pgprot)
 
 #define __pte(x)        ((pte_t) { (x) } )
@@ -36,14 +36,28 @@ typedef struct { pteval_t pgprot; } pgprot_t;
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
+	 * A PGD entry actually corresponds to two PMD entries in the PMD table.
+	 * Both PMD entries point to PTE tables residing in the same physical page,
+	 * but at different offsets. See include/asm/pgtable-2level.h for details.
+	 *
+	 * Historically, pgd_val() has returned the lower of the two PMD entries.
+	 */
+	return (*(pmdval_t (*)[2])&pgd)[0];
+}
+
 #define pgprot_val(x)   (x)
 
 #define __pte(x)        (x)

-- 
2.43.0

