Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08D476CF6;
	Wed, 22 Jul 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734263; cv=none; b=pIGTZtcH4Aa+6l8MpIXWMWoeGDy4ee+I6QRWAVhjA4gE4M+ZYPQ0HRXL6y9mcJiz6M66ZuWDsHI2iA1XQcf8e4oDTyEuGTLoaoAcAyNbzqx50ShM6LsVv/fqoE0Y98yktqJyWeGv/+VpPUIci9sEW6SVEODoJJG1ElwxVpKbrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734263; c=relaxed/simple;
	bh=QrVPpGpdi/eED4dW1HaGgNR2pJxPks6zPqeAqIGp2c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpIAF8Z5tvT9+15NDY4UNZfiV+9Dy7e6/mRsAtI8m2VLIZYHpFfgkM0gvYJYS37243jmHq8O91hMguBRUI0GOvlYzNkEgjKdovB+5Sry6J5LWYL5UpCNL1aRJxhai7nY2m2/upUaeZ4tmm6NeFDMr3ExhgAyZykkQSlkA/q2Fqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sx7wtw/4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sx7wtw/4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB4DB168F;
	Wed, 22 Jul 2026 08:30:57 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12DE83F66F;
	Wed, 22 Jul 2026 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734261; bh=QrVPpGpdi/eED4dW1HaGgNR2pJxPks6zPqeAqIGp2c0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sx7wtw/4z23ZqWgZrrke2cLsWwmVryD0piVvxP5yDoWYdAI4LejZxWJjAx7VCXeFj
	 XxlBVB31lMo8WMO0RW7nTFFAbLeq23q0DfH91pTlZcCEROxikJkt9oVDE3Hv9+sPO4
	 MNzvkiIBTNf3FYe9RkItoVkvNmFyJJGAKNecB4sk=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:11 +0100
Subject: [PATCH RFC v2 03/20] ARM: mm: remove custom pgdp_get()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-3-d9e4bad31e0a@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=imCIbsDy8jWM4y7+JQNzM8t/o1T4VNesyR2iG+vBinE=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIQ7gH2xG3dGNa5zWIxKkCj6heJC6TxnwWDG
 j715ctcwS6JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiEAAKCRBt1cPRWsUx
 M0iEDACSAXRGBpMxC/K5FYE+A8U6TjqE6WPR6uVtpTp4G3Ulkg3GiAy62KmADuZ/1YGRLTqtioB
 SdXgnkpNWIpVmbvcXCxvLM4JngQLqdwGN2Tmkq/E7pjPVfMB2A3IlViVxIOIAIY/hhQzXV+yp0N
 SSIpwtdt3xL3PHaoE7k7j6EXAhTrAXOlpUhi/1YOZ2KR3tA1vDaX+zz5v43oCXPcUwuzPVWiNsR
 gBNzXs5iUtMNDnepvlm1EkCJNglxpEVCKSZXfhItaNffxHBi8qFpApORlfFfgo82PzlaWlOyH0z
 LXiuXGqDG0qTAhzC9PhbfS4Ppx+63phAq5bhkgEQsP9/zsIb5BMpfTw6Q7Ig5V5wGO3YRiCaqpH
 1Hx4bDGaJ6B0NW84rfJG7zCHUg5dv8FqnopAzS/cPUj8wq1UsNKs9Zwiq6SwXB+Ff95tjEG69vu
 ZAASVFVOH8dS3VQRZqe2XcEJyHiu8f0GNrl/Nf9QLzMl3+Q4g/upKuF1Z9aCcoPziBSao=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

Now that pgd_t is no longer an array, we can just rely on the common
code pgdp_get(), which is a static inline function that returns pgd_t.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/arm/include/asm/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 982795cf4563..eadd027fe0ee 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -141,8 +141,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
-#define pgdp_get(pgpd)		READ_ONCE(*pgdp)
-
 #define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
 #define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
 

-- 
2.43.0

