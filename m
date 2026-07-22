Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE5943BDAA;
	Wed, 22 Jul 2026 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734385; cv=none; b=r79dO6fzY6K5xhPKPA7qW+Fv//WdDbHFGXEfPi97LGMbyzls18Udz9llQJmngLXcmneop4+UbW5DLm8ryNjdCC6iPDsKNSP7e9n7lBS2P0K21fabA2i4QEh4fdKny2Fct5CZOJYqEUy+D6oQ5K0ZWYgiAmregmhBfx9+AxWtRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734385; c=relaxed/simple;
	bh=k+Ct6UKfsw6TgQhfFM/Z3zSeUfS2RWT0nIS47WctCoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btsGaWbH6fNC8eIwjS7cUknfJ+MugJG+ez4OX9AoCDgkU4aKPZ/tX8+mTZJZAUK1qFT+cIfyGFlgXLHf0aifB0+QYoGfV4fBlAJiDkVX2qxqnEpFWdxP6b/OkLs+57A4f8oS9gGHBa7RtpVJWHDQcw6nog54q04j/cgPo/q/F2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=g0nt6IZQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="g0nt6IZQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE34168F;
	Wed, 22 Jul 2026 08:32:59 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B563F66F;
	Wed, 22 Jul 2026 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734383; bh=k+Ct6UKfsw6TgQhfFM/Z3zSeUfS2RWT0nIS47WctCoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g0nt6IZQyCvKgFZI60DRcC/GGffDPb2GQYIKllqDpAFm2g3BxA4jSQds3cRGSkeX+
	 Tmrbtu+qVu7CkkGqnfFFoBLy5zASiJCTJuvf7Q9ZTGipqgz23ZCnK/giM7u1gcWK6V
	 V0zdJQpZ9klZ7UIIQa1LjhJUG8roKpNnBr50gWEk=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:28 +0100
Subject: [PATCH RFC v2 20/20] arm64: pgtable: convert pte_present() from
 macro to static inline
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-20-d9e4bad31e0a@arm.com>
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
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3788; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=k+Ct6UKfsw6TgQhfFM/Z3zSeUfS2RWT0nIS47WctCoI=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIZ28tsQPrNiVpXVTDwHe/CTrQCbHUFRJazg
 yJ2euBUl/WJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiGQAKCRBt1cPRWsUx
 M0S9DADGM2RD+DFrHP2YJpZpPcTcyVH/TMAS0pwVsW1g4uxtvIdtn63hJRlaxQu5urXc+Lq/RBH
 m65O3NKvfrVe/lONng8d0oSO9qWVcb88cWdEc/UMikc0hRViojalruYvg/j9Whge9O6REkHj4ef
 MCBpDPKXxJQnITLIphQp/inT602yb0Mc9ysYANV1nwHgfOlC+OkN1zMNOMeR9xAf1fDaAenzXob
 LH+Yv5ZeXfazFPG7QMZdsxejPVcuI8MGbXHDgjKPJW3VMRjAik4WPeD9L/7oWOopkz38RUIjNdu
 BiEPWbt7ZEuo9CE3Sh1yvzdKeBP55+kDJzxEPHfsed+tWtYBkw7Mgrx3hy1MbbltZ/TJAbZUwgB
 AKOmwqNxTPy7ZL2XMNPiavDxP8JhogFcR0yI9RvWg0KswIjItJfbV50X72kJrZalSNSOtsjgpwi
 SSuYz91oqX04BKa5QahApperz7grEN93/1UeYbDnaCBVnMAVl57yy1+slrRnHZyOohJ88=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

pte_present() is used as the basis for both pmd_present() and pud_present().
It is currently implemented as a macro composed of pte_val() and
pte_present_invalid().

When pte_present() or its higher-level variants are used directly with
ptep_get() or pXdp_get(), for example:

  pte_present(ptep_get(pte));
  pmd_present(pmdp_get(pmd));
  pud_present(pudp_get(pud));

the macro expansion causes the compiler to evaluate the argument twice,
resulting in redundant loads. For example, pte_present() expands to:

  !pte_val(READ_ONCE(*pte) || pte_present_invalid(READ_ONCE(*pte))

A typical example is pud_free_pmd_page(), where the expansion of
pmd_present() generates:
    ...
    /* pmd_present() (x20 = pmdp) */
    1b88: f9400288     ldr	x8, [x20]        // read pmdp.
    1b8c: f9000fa8     str	x8, [x29, #0x18]
    1b90: 3707fec8     tbnz	w8, #0x0, 0x1b68 <pud_free_pmd_page+0xd0>
    1b94: f9400288     ldr	x8, [x20]        // redundant read of pmdp.
    1b98: 8a170109     and	x9, x8, x23
    1b9c: f9000fa8     str	x8, [x29, #0x18]
    1ba0: f120013f     cmp	x9, #0x800
    1ba4: 54fffe20     b.eq	0x1b68 <pud_free_pmd_page+0xd0>
    1ba8: 17fffff4     b	0x1b78 <pud_free_pmd_page+0xe0>
    ...

Convert pte_present() to static inline function so that prevent the
generation of redundant code and move pte_valid() and
pte_present_invalid() further up so the inline function can use them.

After this change, the generated code becomes:
    ...
    /* pmd_present() (x20 = pmdp) */
    1a30: f9400288     ldr	x8, [x20]
    1a34: 8a170109     and	x9, x8, x23
    1a38: f9000fa8     str	x8, [x29, #0x18]
    1a3c: f120013f     cmp	x9, #0x800
    1a40: 54fffe80     b.eq	0x1a10 <pud_free_pmd_page+0xd0>
    1a44: 3607fee8     tbz	w8, #0x0, 0x1a20 <pud_free_pmd_page+0xe0>
    1a48: 17fffff2     b	0x1a10 <pud_free_pmd_page+0xd0>
    ...

This eliminates the redundant load and also reduces code size at
call sites using this pattern. For example, pud_free_pmd_page() shrinks
from 7,500 bytes to 7,148 bytes, a reduction of approximately 4.7%.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6185fc291fd7..aaae3d14895f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -140,10 +140,17 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_none(pte)		(!pte_val(pte))
 #define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
 
+#define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
+#define pte_present_invalid(pte) \
+	((pte_val(pte) & (PTE_VALID | PTE_PRESENT_INVALID)) == PTE_PRESENT_INVALID)
+
 /*
  * The following only work if pte_present(). Undefined behaviour otherwise.
  */
-#define pte_present(pte)	(pte_valid(pte) || pte_present_invalid(pte))
+static __always_inline bool pte_present(pte_t pte)
+{
+	return pte_valid(pte) || pte_present_invalid(pte);
+}
 #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
 #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
 #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
@@ -168,9 +175,6 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
 #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
 
-#define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
-#define pte_present_invalid(pte) \
-	((pte_val(pte) & (PTE_VALID | PTE_PRESENT_INVALID)) == PTE_PRESENT_INVALID)
 /*
  * Execute-only user mappings do not have the PTE_USER bit set. All valid
  * kernel mappings have the PTE_UXN bit set.

-- 
2.43.0

