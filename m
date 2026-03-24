Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AED3F99C9;
	Tue, 24 Mar 2026 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358821; cv=none; b=RQt8HHglZXw5wPSYYHfdrN/1eVUr+JnE+pkzLNttO4ncbtKpcGhHqI4juX02F+NEC7psB1DyCeGQA0VCF14Vw9BwZzDqgbBGfLUxXK6PDoD/v0gsaEzVcp0tqqTXoZj7B7E/5vq57W3jlUa4YyrCPhU4KcX7yk5IP+AygdNWiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358821; c=relaxed/simple;
	bh=VhBd0SXQdStB06Ok11/K+KdOFOf0X6cWYTl++e9UdAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQhHHTwiBOBsb7/JRAjA2LQazKwUKrguP9PaqTCZe8An/rt517uC2ckMiBkm1nGxhJFL8Zn+Ec52kqYJBLaU0ao871tXkG9mq2Spd4oHjFElFt4oSmNYfhtcjnNb0X962MR40EHf7foB7PT6IRNiGH9dXsWEsOcX+MZgacNrpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Lay9mLSy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Lay9mLSy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10331153B;
	Tue, 24 Mar 2026 06:26:52 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.1.194.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD88D3FAF5;
	Tue, 24 Mar 2026 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774358818; bh=VhBd0SXQdStB06Ok11/K+KdOFOf0X6cWYTl++e9UdAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lay9mLSy/mKrnA78g3qAMj48V6DZbVTZSKlQxfMcJT4P58/f6HDrxW5nnkZWA7i8v
	 N4bdPcm3lyqUJky+4QOxQgv/m7/DvVhfe7M0UEBh86twBM/C8F7Ld4W4yjKhXniipe
	 nOYfehEH0YKbdvhLs6jdw2/ti3BtLFWLvp1/FCCE=
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
Subject: [PATCH v2 2/3] kasan: skip HW tagging for all kernel thread stacks
Date: Tue, 24 Mar 2026 13:26:28 +0000
Message-ID: <20260324132631.482520-3-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324132631.482520-1-usama.anjum@arm.com>
References: <20260324132631.482520-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HW-tag KASAN never checks kernel stacks because stack pointers carry the
match-all tag, so setting/poisoning tags is pure overhead.

- Add __GFP_SKIP_KASAN to THREADINFO_GFP so every stack allocator that
  uses it skips tagging (fork path plus arch users)
- Add __GFP_SKIP_KASAN to GFP_VMAP_STACK for the fork-specific vmap
  stacks.
- When reusing cached vmap stacks, skip kasan_unpoison_range() if HW tags
  are enabled.

Software KASAN is unchanged; this only affects tag-based KASAN.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
Changes since v1:
- Specify _GFP_SKIP_KASAN in THREADINFO_GFP and GFP_VMAP_STACK to use
  it everywhere and cover the missed locations
- Update description
---
 include/linux/thread_info.h | 2 +-
 kernel/fork.c               | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 051e429026904..307b8390fc670 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -92,7 +92,7 @@ static inline long set_restart_fn(struct restart_block *restart,
 #define THREAD_ALIGN	THREAD_SIZE
 #endif
 
-#define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO)
+#define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_SKIP_KASAN)
 
 /*
  * flag set/clear/test wrappers
diff --git a/kernel/fork.c b/kernel/fork.c
index bb0c2613a5604..4bc7a03662109 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -207,7 +207,7 @@ static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
  * accounting is performed by the code assigning/releasing stacks to tasks.
  * We need a zeroed memory without __GFP_ACCOUNT.
  */
-#define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO)
+#define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO | __GFP_SKIP_KASAN)
 
 struct vm_stack {
 	struct rcu_head rcu;
@@ -345,7 +345,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		}
 
 		/* Reset stack metadata. */
-		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
+		if (!kasan_hw_tags_enabled())
+			kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
 
 		stack = kasan_reset_tag(vm_area->addr);
 
-- 
2.47.3

