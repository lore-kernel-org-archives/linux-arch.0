Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D9C3CD8C5;
	Thu, 19 Mar 2026 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921015; cv=none; b=SQYi3ds2E8xIVcGwnoa8e17LT8LZkZFpuN++eC7E1QsTubhik40/lnN1YZW/9EBrrTQqIr9HFNnW6nvoidwVNoUkzZxMDBkFGGVN5klgUACBo0Sc39CI/M9COVLO6Vlq9CT7hGcDduMta4gwbAL9nY61uNR0So6rka2yvikIr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921015; c=relaxed/simple;
	bh=VbJHDsgOUKafanpIO//j3se8TUFIElNcsQTywAb0pqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2qY2qs5o+8E9ttuQhYGH+7Hv4XBZeOymU5ar3sGgyFrfMkBraC93pDRS9da/+IMhcHtASqxEO/fcNCnYXfvwrxtjbWRajWhUi39CGNaB2y/PZDu36l3S3asMasw+qbffRlW/MT9s5HLCz7c+h8L9j4K+Y6JwJd98D+zLpVJAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74FB82050;
	Thu, 19 Mar 2026 04:50:07 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.1.194.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 438E03F778;
	Thu, 19 Mar 2026 04:50:09 -0700 (PDT)
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
Subject: [PATCH 2/3] fork: skip MTE tagging for kernel stacks
Date: Thu, 19 Mar 2026 11:49:45 +0000
Message-ID: <20260319114952.3241359-3-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319114952.3241359-1-usama.anjum@arm.com>
References: <20260319114952.3241359-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stack pointer always uses the match-all tag, so MTE never checks
tags on stack accesses. Tagging stack memory on every thread creation
is pure overhead.

- Pass __GFP_SKIP_KASAN in gfp_mask for vmalloc-backed stacks so the
  vmalloc path skips HW tag setup (see previous patch).
- For the cached VMAP reuse path, skip kasan_unpoison_range() when HW
  tags are enabled since the memory will only be accessed through the
  match-all tagged SP.
- For the normal page allocator path, pass __GFP_SKIP_KASAN directly
  to the page allocator.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 kernel/fork.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bb0c2613a5604..2baf4db39b5a4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -345,7 +345,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		}
 
 		/* Reset stack metadata. */
-		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
+		if (!kasan_hw_tags_enabled())
+			kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
 
 		stack = kasan_reset_tag(vm_area->addr);
 
@@ -358,7 +359,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	}
 
 	stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
-				     GFP_VMAP_STACK,
+				     GFP_VMAP_STACK | __GFP_SKIP_KASAN,
 				     node, __builtin_return_address(0));
 	if (!stack)
 		return -ENOMEM;
@@ -410,7 +411,8 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
-	struct page *page = alloc_pages_node(node, THREADINFO_GFP,
+	struct page *page = alloc_pages_node(node,
+					     THREADINFO_GFP | __GFP_SKIP_KASAN,
 					     THREAD_SIZE_ORDER);
 
 	if (likely(page)) {
-- 
2.47.3

