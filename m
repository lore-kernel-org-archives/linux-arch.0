Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12A23370F;
	Fri, 24 Apr 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035753; cv=none; b=s6KJWLlylN51JzXi7MMhP3D/M6l4o5zl0Yic0w+qqDhUXRQzsJV46QFhOtlNvTBJJntKGzREZCQvnzQNFfjRv9A3xoCI3fz9QJO4wuPl5RvRhtuMJMJBaCaDYYRiFxCmTQ0AZXOoCerD4HPVPNMpcPBfDxqYzA1STU7Wzj6q83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035753; c=relaxed/simple;
	bh=D5X8BJo1eAEFDfHp+6/7s8DHory+FJuzYWqDtfEml9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FiYgNlvc2o7kgTgZHlCWYIiUsm6kS25DlpYexGOTpBRJhrG8Q5aAXzpsk7l45U2Gk8h8vO0DfvCoM0UhhrrtSCsFbR0vVGVT+NydHZ0cy1W1W0Pt9phnh1YqtfO5uWiYYptk4E7Zfqu+TctMYu+In1yWD0aYndZ+wpCnLfzQBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cnyc3BZB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cnyc3BZB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFDAD1BB2;
	Fri, 24 Apr 2026 06:02:25 -0700 (PDT)
Received: from a080796.blr.arm.com (a080796.arm.com [10.164.21.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B82C73F641;
	Fri, 24 Apr 2026 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777035751; bh=D5X8BJo1eAEFDfHp+6/7s8DHory+FJuzYWqDtfEml9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnyc3BZB7O71ynREGNf8/mo1oBmy01E7og062JAqbqLMBgR0ll2SwQ1Ir4hR3vbo4
	 uQbijEIjNYmKrks9VDj1noDm2aOzJMvl1ZBpaEEfHD+ZDaeHALsPThR7hZ8IQLtzy0
	 x989bATNcafg3pXnY5auXxZzSo1+thLH4tTnUHjk=
From: Dev Jain <dev.jain@arm.com>
To: arnd@arndb.de,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	urezki@gmail.com
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	tglx@kernel.org,
	usama.anjum@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 2/3] kasan: skip HW tagging for all kernel thread stacks
Date: Fri, 24 Apr 2026 18:31:56 +0530
Message-Id: <20260424130157.3163009-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424130157.3163009-1-dev.jain@arm.com>
References: <20260424130157.3163009-1-dev.jain@arm.com>
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
index bc2bf58b93b65..2fc3b121962cb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -202,7 +202,7 @@ static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
  * accounting is performed by the code assigning/releasing stacks to tasks.
  * We need a zeroed memory without __GFP_ACCOUNT.
  */
-#define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO)
+#define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO | __GFP_SKIP_KASAN)
 
 struct vm_stack {
 	struct rcu_head rcu;
@@ -340,7 +340,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		}
 
 		/* Reset stack metadata. */
-		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
+		if (!kasan_hw_tags_enabled())
+			kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
 
 		stack = kasan_reset_tag(vm_area->addr);
 
-- 
2.34.1

