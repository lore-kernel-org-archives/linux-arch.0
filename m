Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D870947CA9A;
	Wed,  2 Sep 2026 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350228; cv=none; b=WRuMTU3I+2LO8XiLsYM8LwofK8r/e2QRYRcAUIVwvlRNMjJQokEK43GnW6FGa6VvRYFEF+6Jdkv1rLYYQmjmvu8+a45tMbeH1V4qlaKS3RNS4ldXA2VIspSbDp1X0gr6GdKWjq8F8oxA7HqcNPgyY23uBmQnjrK7stvC84oaZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350228; c=relaxed/simple;
	bh=mi4xjJsCAhGuG1KP2jLhKq+FK/V2NIyuuhsagoZBG7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NW01sZWzpGZZhWo3ISQP1/soIsQZLs+88VaE5kpovZIhUKRTeXjNqUTD4+um4UcJxnv8To2q1Cb26tEMVnDfPOYr0Ew6XBxyu36VMz66GgqJASg26LBFmkqJGaCd7pcnSPNX6uQ4RnYR4mZPfP3zXfdcHIxwCTNNw7IjdkaMRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DBs+SEJ/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DBs+SEJ/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961661596;
	Wed,  2 Sep 2026 04:56:54 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EC283F85F;
	Wed,  2 Sep 2026 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350218; bh=mi4xjJsCAhGuG1KP2jLhKq+FK/V2NIyuuhsagoZBG7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DBs+SEJ/tWGTTLaux+S1LwsrrYGBwQV3ATuKZgMbvei+jVh1WSY/M2QC4NxmGgA1y
	 i7m5xO5OZ/Kze26/9ZcqAvwphvv8ZcI6T4TjkMJLHNM7089rPf0Uh66u16hKJ2O/bw
	 eUVTOabXRMEhFzmJCMwjz8dAs2j1D7hwhGxnsB4s=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 02 Sep 2026 12:56:05 +0100
Subject: [PATCH RFC v3 03/21] ARM: mm: remove custom pgdp_get()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-dummy_ptxp3-v3-3-5d8f5b17c25c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=Kei+qz90eZd/Rla66RuJIaqD0aMM/I6F6uU024NhR+s=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqmA7jjEkXgd07toBiXhGHtW6l2HJSNxf8EJFQR
 MrLQ8sVkn2JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCapgO4wAKCRBt1cPRWsUx
 M6UpDACvafb5I6qRyuKtjC3o3BB6X1x2pDkn7WzYN1XkHRJTOSQqVabpYB98QmaZehBIp+rjcY5
 8XhZPr4/VlBHOVk3oTKXafUozy78zoYZq0S0E3Lf2aAZxvVYJ2NiTRRojaaLsZjYC90Gh0q972O
 Rz/p7u4wzhU9+zIBlnLnLO0sHStfpkZzqgRmFRNN/cNQcudRxV/D0DvX3QUiHospfakh8Gzd+tw
 YagxhalJiyRHw1OpcDf+m4tYW4H3OvMHS425VPwVBRIIouFfanScIRA0+fKzG0k4IK2M2wrA02H
 KrgC0K5GAs47HdDG3A/K8w5D4465AqabgyFWC/Z45fkdQwIBIeMAYZZ0m0GQzSVgwFcP4uCsTeT
 g65+aH2rnoY/2z+l0jnY4nIE9dI1zATCV6ZhkOXlXqpUwtP1NdLmkFwU+Dzgi7M8aclQ4OMOAwx
 Hd2do+6aUtYqw9yndif4b5hrcikHznxCCtm2jeKnhCm3VafyuCD3Yr1/8LH2X6S9Li8T4=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

Now that pgd_t is no longer an array and rely on the common
code pgdp_get(), which is a static inline function that returns pgd_t.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/arm/include/asm/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 8dd17d20faa3..ff3868acea94 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -134,8 +134,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
-#define pgdp_get(pgpd)		READ_ONCE(*pgdp)
-
 #define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
 #define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
 

-- 
2.43.0

