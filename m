Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A564137AE;
	Thu,  6 Aug 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005644; cv=none; b=fn2GoI7uv2YyiwieOEtpses6ctDMYfcff/EdTC4biPjGUSRx9Bss8ofy28o8Dd1pOKA4E2iV0c6/YswDXBZfxPOqfZr60vDt1PDW979DkBZAGIp4Od0+2LqPcb8ULFBNBkBQyGQd6xUvTxrttycp5JFBGf8vXlqfqkyAcUf/+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005644; c=relaxed/simple;
	bh=N7Kx8cypRY/4tgLqgkZyPCXbOC37nDVo81ML0oOq7lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI4eUZHkrkvHusC0F9rWm3h7HNwySEF7SDULYAyBVk5HuG29reGi+NaBiJIB7rFJlsRleAcaKhHwN/z0SFTp7ZLfE42NGUc+/lXWwsRC34Wl4B3Q094BKGdtO7XF0JJUkMf80QS5RWWJujJnKixqAkdQDRE8uLZOGJV+4UNqXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tagQFezC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tagQFezC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 639B819F0;
	Thu,  6 Aug 2026 01:40:30 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AF5F3F9A2;
	Thu,  6 Aug 2026 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786005634; bh=N7Kx8cypRY/4tgLqgkZyPCXbOC37nDVo81ML0oOq7lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tagQFezCw9aBUWT7bOfI3ipYrSvBgGoc0nvAu5XpEVT8jAWZTUXoDkAzn54+nSZu/
	 C0359lFjQAXDgtRxm2t3RSVQ591J+t3FxW0ZNLk6ZGX5bMdhv/n3Wr7ekNo3EB6nJi
	 fG5//UTE+Z1Arn0RcPLdaPIBOCt1BQtKZG1psE+U=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	SJ Park <sj@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	ziy@nvidia.com,
	pfalcato@suse.de,
	agordeev@linux.ibm.com,
	ryan.roberts@arm.com
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH 5/9] mm: convert PTE table entries in ptep_get()
Date: Thu,  6 Aug 2026 09:38:43 +0100
Message-ID: <20260806083926.1807279-6-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806083926.1807279-1-usama.anjum@arm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
return a logical pte_t value. Add __pte_from_hw for both generic hw_pte_t
definitions. Read the hw_pte_t table element atomically before converting
it to pte_t.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
Changes since RFC v1:
- Define __pte_from_hw for the opted-in generic wrapper.
- Apply READ_ONCE() to hw_pte_t before converting it to pte_t.
---
 include/linux/pgtable.h       | 2 +-
 include/linux/pgtable_types.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index dad80d264aac2..1768421755a9c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 #ifndef ptep_get
 static inline pte_t ptep_get(hw_pte_t *ptep)
 {
-	return READ_ONCE(*ptep);
+	return __pte_from_hw(READ_ONCE(*ptep));
 }
 #endif
 
diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
index 70c3edd00a01b..a625516fd67b1 100644
--- a/include/linux/pgtable_types.h
+++ b/include/linux/pgtable_types.h
@@ -8,8 +8,10 @@
 
 #ifdef CONFIG_ARCH_HAS_HW_PTE_T
 typedef struct { pte_t __pte; } hw_pte_t;
+#define __pte_from_hw(pte)	((pte).__pte)
 #else
 #define hw_pte_t pte_t
+#define __pte_from_hw(pte)	(pte)
 #endif
 
 #endif /* !__ASSEMBLY__ */
-- 
2.47.3

