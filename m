Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5553D5223;
	Wed, 29 Apr 2026 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458493; cv=none; b=KOO2dWRZ0DK2cpWo+4e0SMMVUtYZfckp8CpeRRPm7FuL7MgBYtUPWE813VvNt53q6kTIiJ7NnuAS59F2hScKpXQjtHCVf+SqDr0B2sCUoNxVQIaqF6/6PHzP+IDkGMlMHDBryqNRe51JIz5+R9ONoe4lLlkYtDea73IHDc211A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458493; c=relaxed/simple;
	bh=orXsq89dfQMCSKEE6gPmHluNEOO7CXeI2G3nz7AJ8FI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hg71AJUBrwqw6CiKifKB9IyeuIYFpFzKz1G1RRlhcIiwS2MOKXAAKpYmnZaPpwXmTTAm6BooObUr20Jv1OKN5Ep8l1/ijy9bh2AKWzcoandKoi6w0tt9vqjoLDvmr3dSpqRwMK53zZ68LtD9iEOWvlRWYTJJ3SOGTQqtZFLC0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ESGGwOF8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ESGGwOF8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F315C2A68;
	Wed, 29 Apr 2026 03:28:05 -0700 (PDT)
Received: from a080796.blr.arm.com (a080796.arm.com [10.164.21.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27B373F763;
	Wed, 29 Apr 2026 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777458491; bh=orXsq89dfQMCSKEE6gPmHluNEOO7CXeI2G3nz7AJ8FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESGGwOF8xqj5DfideHRgMZPn34oyBQ6v/NvyCJ/O6ZI8vg7vKVveDC/MpnPb6fhwj
	 aw3fI5JsSJb1H0svna9O1P6MJOvk+cOzwAzkiPO5rCLHD8VxJuCWDKgok+U8ys1LOi
	 YzxVjTJulqfYNz6cPeW/GcShU6dm60uDJwDqghz4=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	urezki@gmail.com,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	arnd@arndb.de
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	tglx@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org,
	ryan.roberts@arm.com,
	catalin.marinas@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v4 2/3] kasan: skip HW tagging for all kernel thread stacks
Date: Wed, 29 Apr 2026 15:57:03 +0530
Message-Id: <20260429102704.680174-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429102704.680174-1-dev.jain@arm.com>
References: <20260429102704.680174-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Usama Anjum <usama.anjum@arm.com>

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
Signed-off-by: Dev Jain <dev.jain@arm.com>
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
index f1ad69c6dc2d4..0d97fd71d7f60 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -204,7 +204,7 @@ static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
  * accounting is performed by the code assigning/releasing stacks to tasks.
  * We need a zeroed memory without __GFP_ACCOUNT.
  */
-#define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO)
+#define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO | __GFP_SKIP_KASAN)
 
 struct vm_stack {
 	struct rcu_head rcu;
@@ -342,7 +342,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		}
 
 		/* Reset stack metadata. */
-		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
+		if (!kasan_hw_tags_enabled())
+			kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
 
 		stack = kasan_reset_tag(vm_area->addr);
 
-- 
2.34.1

