Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F13CBE77;
	Thu, 19 Mar 2026 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921011; cv=none; b=N6WjyMw1SCLQ1ePizXTkT/WGr4ijppX0WB1azTpp6NyId470F5BKXIWRVg5MBpYVy0aD0ZDXP/X18/dLZPvB1jSOlg0eeHibPkkE4qenZXXm9XqJeF7fudEubbBKRSgR7XS4U+4J6PsHW/TRJOFY3RMlU+tFxbGsw2l5ivl7Q5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921011; c=relaxed/simple;
	bh=1A19svTFNimiMX0p7MePOMchlMQE04htLe+BZ1KV7so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnnEOTR10AtjdbpMIketAh/JGXSmZxooY7eGGm9eMEzlBcdI0ZtZT66s9tryQznKWyli0u3ZfOHjL/CQMBfPMs2lxOiyjD44lWs2nqfgevpWAQpbsEAI1ZT6NCdfwWb50V1UqFKwFDYe74XeMp4RmX1h9Sz0r65t8vwYp9esvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2FDC1BD0;
	Thu, 19 Mar 2026 04:50:02 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.1.194.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3FE63F778;
	Thu, 19 Mar 2026 04:50:04 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@arm.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Peter Collingbourne <pcc@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan.Roberts@arm.com,
	david.hildenbrand@arm.com
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Subject: [PATCH 1/3] vmalloc: add __GFP_SKIP_KASAN support
Date: Thu, 19 Mar 2026 11:49:44 +0000
Message-ID: <20260319114952.3241359-2-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319114952.3241359-1-usama.anjum@arm.com>
References: <20260319114952.3241359-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For allocations that will be accessed only with match-all pointers
(e.g., kernel stacks), setting tags is wasted work. If the caller
already set __GFP_SKIP_KASAN, don’t skip zeroing the pages and
don’t set KASAN_VMALLOC_PROT_NORMAL so kasan_unpoison_vmalloc()
returns early without tagging.

Before this patch, __GFP_SKIP_KASAN wasn't being used with vmalloc
APIs. So it wasn't being checked. Now its being checked and acted
upon. Other KASAN modes are unchanged because __GFP_SKIP_KASAN isn't
defined there.

This is a preparatory patch for optimizing kernel stack allocations.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 mm/vmalloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c607307c657a6..1baa602a0b9bb 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4041,7 +4041,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	 * kasan_unpoison_vmalloc().
 	 */
 	if (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
-		if (kasan_hw_tags_enabled()) {
+		bool skip_kasan = kasan_hw_tags_enabled() &&
+				  (gfp_mask & __GFP_SKIP_KASAN);
+
+		if (kasan_hw_tags_enabled() && !skip_kasan) {
 			/*
 			 * Modify protection bits to allow tagging.
 			 * This must be done before mapping.
@@ -4057,7 +4060,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		}
 
 		/* Take note that the mapping is PAGE_KERNEL. */
-		kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;
+		if (!skip_kasan)
+			kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;
 	}
 
 	/* Allocate physical pages and map them into vmalloc space. */
-- 
2.47.3

