Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8D4A2E2C;
	Tue,  5 May 2026 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001003; cv=none; b=ACiq/ExeTGG6kuYiWcLbvmJufD4Zg/ZEYWRUECqlBfE9PvI5gWItWNVUCuhVjyBPYg5ldbNyZjjz1+SmQKiRnRi3zKCf3cTUdj+Jwt4M1n6XKhS+wfh/AOSCyjfzOfq9UBwewgmEUyjUUAJAzjL2Hahbgq1nTEepOw3CymwDbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001003; c=relaxed/simple;
	bh=Hxgm4nyRXG7am7evRAcxkckPyVlEd1UOmeLxYJCJOHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcQrsH8PsJ1JTXsWulOS77jBzEJmQ0Cz2ea5yYFch5j0zO7EpXnf+W3Id2qoa/oKKzc9ib9XdDwDv1AyKpEHZI280BNd7TbggYfs48fK1oFPFvmEsNBcikqST/uP2v+9cHYlAmyLMMr+3eAzQjoBmqoVoayttGlNoSs+1+N56Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=NddL6V50; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="NddL6V50"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 5D462CFFFB;
	Tue, 05 May 2026 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1778000994;
	bh=0iNiXafam+/e0hkdJzF6nIr0O4d4HoUoH1x5V8VkIAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NddL6V50gn9QHy1qO45QfNnsCGY22x/FGJ9pE4goYDRaBNmo5J1FEz/pCZ86C3hfQ
	 bXOIi3qyfbj1qjkBuNbWqzN7Yja6FSueSZPaV5S5oU1HXvzY9z7SUhaiQWQKfOUvLe
	 QG3eIABqUNEWkkCnlSPfPahP+NN2+iFMyyJjTW5U=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v6 4/7] locking: Factor out queued_spin_release()
Date: Tue,  5 May 2026 17:09:33 +0000
Message-ID: <64c202b8a76a7d98515cf10cc1f99ecb0a9a7ccf.1777999826.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1777999826.git.d@ilvokhin.com>
References: <cover.1777999826.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce queued_spin_release() as an arch-overridable unlock primitive,
and make queued_spin_unlock() a generic wrapper around it.

This is a preparatory refactoring for the next commit, which adds
contended_release tracepoint instrumentation to queued_spin_unlock().

Rename the existing arch-specific queued_spin_unlock() overrides on
x86 (paravirt) and MIPS to queued_spin_release().

No functional change.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/mips/include/asm/spinlock.h         |  6 +++---
 arch/x86/include/asm/paravirt-spinlock.h |  6 +++---
 include/asm-generic/qspinlock.h          | 15 ++++++++++++---
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 6ce2117e49f6..c349162f15eb 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -13,12 +13,12 @@
 
 #include <asm-generic/qspinlock_types.h>
 
-#define	queued_spin_unlock queued_spin_unlock
+#define	queued_spin_release queued_spin_release
 /**
- * queued_spin_unlock - release a queued spinlock
+ * queued_spin_release - release a queued spinlock
  * @lock : Pointer to queued spinlock structure
  */
-static inline void queued_spin_unlock(struct qspinlock *lock)
+static inline void queued_spin_release(struct qspinlock *lock)
 {
 	/* This could be optimised with ARCH_HAS_MMIOWB */
 	mmiowb();
diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/paravirt-spinlock.h
index 7beffcb08ed6..ac75e0736198 100644
--- a/arch/x86/include/asm/paravirt-spinlock.h
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -49,9 +49,9 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
 				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
 }
 
-#define queued_spin_unlock queued_spin_unlock
+#define queued_spin_release queued_spin_release
 /**
- * queued_spin_unlock - release a queued spinlock
+ * queued_spin_release - release a queued spinlock
  * @lock : Pointer to queued spinlock structure
  *
  * A smp_store_release() on the least-significant byte.
@@ -66,7 +66,7 @@ static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	pv_queued_spin_lock_slowpath(lock, val);
 }
 
-static inline void queued_spin_unlock(struct qspinlock *lock)
+static inline void queued_spin_release(struct qspinlock *lock)
 {
 	kcsan_release();
 	pv_queued_spin_unlock(lock);
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index bf47cca2c375..df76f34645a0 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -115,12 +115,12 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 }
 #endif
 
-#ifndef queued_spin_unlock
+#ifndef queued_spin_release
 /**
- * queued_spin_unlock - release a queued spinlock
+ * queued_spin_release - release a queued spinlock
  * @lock : Pointer to queued spinlock structure
  */
-static __always_inline void queued_spin_unlock(struct qspinlock *lock)
+static __always_inline void queued_spin_release(struct qspinlock *lock)
 {
 	/*
 	 * unlock() needs release semantics:
@@ -129,6 +129,15 @@ static __always_inline void queued_spin_unlock(struct qspinlock *lock)
 }
 #endif
 
+/**
+ * queued_spin_unlock - unlock a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ */
+static __always_inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	queued_spin_release(lock);
+}
+
 #ifndef virt_spin_lock
 static __always_inline bool virt_spin_lock(struct qspinlock *lock)
 {
-- 
2.52.0

