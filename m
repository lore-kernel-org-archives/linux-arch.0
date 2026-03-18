Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5933E4C95;
	Wed, 18 Mar 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859567; cv=none; b=CpaznOgBBY/s+dQ+x/w0Mrw41tF6SA5OmiDXU6mV8UcEk9MCrBoA/uCr7hffedxPaMbFdnCdgfbclQ5g0dm6bu/Xoogh398zvGp5874WrzaEzVKyZTxvjFt8HI3Xl1xZzzXlHInFYjSrXRh+EtQGg9bGOD9G5M9GQMLq9OvxqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859567; c=relaxed/simple;
	bh=uf9RvEv1xcZX6RCRWRBQH7ivqQXNo4FzJkkXzxzJmpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KThOWVC0Xe+7GA7gFhXSZjeLc10lT+AnACLA+P1RrqvBOTeLq0srvMoGDy1xAuBApZNkoYbLxDbzW25zeiQ7plyaHyivh5SSjkRowtoF4lNckv9X/xzHwtoOT3LHQP/vrEDYkATeI5TPZZ4RtJbu4bkzuvVTn9rZrRKg/xxl6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=gzii1qN3; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="gzii1qN3"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id B906CB3E49;
	Wed, 18 Mar 2026 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773859554;
	bh=UoJMtJZBdJt0FTbec+scIJtxKZOmfkRxPSoXFT7NQCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gzii1qN3ZcHKYIqa7QmKZHgZRA1Jqvy2B437x/KXowu8/6H3zG8LQ/rwgSoiffBwj
	 9Mxbl+/LOeX4RmEJE/y5eIdj4he16ieFYSOLvHc+fJQ9yxfojsxUq7XU6qjdPaBu0N
	 uvUjccWiRig8BnciMa5g2jOr1Geng1zDcg8TZzxE=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [RFC PATCH v3 4/4] locking: Add contended_release tracepoint to spinning locks
Date: Wed, 18 Mar 2026 18:45:21 +0000
Message-ID: <51aad0415b78c5a39f2029722118fa01eac77538.1773858853.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773858853.git.d@ilvokhin.com>
References: <cover.1773858853.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the contended_release tracepoint to queued spinlocks and queued
rwlocks.

When the tracepoint is disabled, the only addition to the hot path is a
single NOP instruction (the static branch). When enabled, the contention
check, trace call, and unlock are combined in an out-of-line function to
minimize hot path impact, avoiding the compiler needing to preserve the
lock pointer in a callee-saved register across the trace call.

Binary size impact (x86_64, defconfig):
  uninlined unlock (common case): +983 bytes  (+0.00%)
  inlined unlock (worst case):    +71554 bytes (+0.30%)

The inlined unlock case could not be achieved through Kconfig options on
x86_64 as PREEMPT_BUILD unconditionally selects UNINLINE_SPIN_UNLOCK on
x86_64. The UNINLINE_SPIN_UNLOCK guards were manually inverted to force
inline the unlock path and estimate the worst case binary size increase.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/asm-generic/qrwlock.h   | 48 +++++++++++++++++++++++++++------
 include/asm-generic/qspinlock.h | 25 +++++++++++++++--
 kernel/locking/qrwlock.c        | 16 +++++++++++
 kernel/locking/qspinlock.c      |  8 ++++++
 4 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 75b8f4601b28..e24dc537fd66 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -14,6 +14,7 @@
 #define __ASM_GENERIC_QRWLOCK_H
 
 #include <linux/atomic.h>
+#include <linux/tracepoint-defs.h>
 #include <asm/barrier.h>
 #include <asm/processor.h>
 
@@ -35,6 +36,10 @@
  */
 extern void queued_read_lock_slowpath(struct qrwlock *lock);
 extern void queued_write_lock_slowpath(struct qrwlock *lock);
+extern void queued_read_unlock_traced(struct qrwlock *lock);
+extern void queued_write_unlock_traced(struct qrwlock *lock);
+
+DECLARE_TRACEPOINT(contended_release);
 
 /**
  * queued_read_trylock - try to acquire read lock of a queued rwlock
@@ -102,10 +107,16 @@ static inline void queued_write_lock(struct qrwlock *lock)
 }
 
 /**
- * queued_read_unlock - release read lock of a queued rwlock
+ * queued_rwlock_is_contended - check if the lock is contended
  * @lock : Pointer to queued rwlock structure
+ * Return: 1 if lock contended, 0 otherwise
  */
-static inline void queued_read_unlock(struct qrwlock *lock)
+static inline int queued_rwlock_is_contended(struct qrwlock *lock)
+{
+	return arch_spin_is_locked(&lock->wait_lock);
+}
+
+static __always_inline void __queued_read_unlock(struct qrwlock *lock)
 {
 	/*
 	 * Atomically decrement the reader count
@@ -114,22 +125,43 @@ static inline void queued_read_unlock(struct qrwlock *lock)
 }
 
 /**
- * queued_write_unlock - release write lock of a queued rwlock
+ * queued_read_unlock - release read lock of a queued rwlock
  * @lock : Pointer to queued rwlock structure
  */
-static inline void queued_write_unlock(struct qrwlock *lock)
+static inline void queued_read_unlock(struct qrwlock *lock)
+{
+	/*
+	 * Trace and unlock are combined in the traced unlock variant so
+	 * the compiler does not need to preserve the lock pointer across
+	 * the function call, avoiding callee-saved register save/restore
+	 * on the hot path.
+	 */
+	if (tracepoint_enabled(contended_release)) {
+		queued_read_unlock_traced(lock);
+		return;
+	}
+
+	__queued_read_unlock(lock);
+}
+
+static __always_inline void __queued_write_unlock(struct qrwlock *lock)
 {
 	smp_store_release(&lock->wlocked, 0);
 }
 
 /**
- * queued_rwlock_is_contended - check if the lock is contended
+ * queued_write_unlock - release write lock of a queued rwlock
  * @lock : Pointer to queued rwlock structure
- * Return: 1 if lock contended, 0 otherwise
  */
-static inline int queued_rwlock_is_contended(struct qrwlock *lock)
+static inline void queued_write_unlock(struct qrwlock *lock)
 {
-	return arch_spin_is_locked(&lock->wait_lock);
+	/* See comment in queued_read_unlock(). */
+	if (tracepoint_enabled(contended_release)) {
+		queued_write_unlock_traced(lock);
+		return;
+	}
+
+	__queued_write_unlock(lock);
 }
 
 /*
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index bf47cca2c375..8ba463a3b891 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -41,6 +41,7 @@
 
 #include <asm-generic/qspinlock_types.h>
 #include <linux/atomic.h>
+#include <linux/tracepoint-defs.h>
 
 #ifndef queued_spin_is_locked
 /**
@@ -116,6 +117,19 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 #endif
 
 #ifndef queued_spin_unlock
+
+DECLARE_TRACEPOINT(contended_release);
+
+extern void queued_spin_unlock_traced(struct qspinlock *lock);
+
+static __always_inline void __queued_spin_unlock(struct qspinlock *lock)
+{
+	/*
+	 * unlock() needs release semantics:
+	 */
+	smp_store_release(&lock->locked, 0);
+}
+
 /**
  * queued_spin_unlock - release a queued spinlock
  * @lock : Pointer to queued spinlock structure
@@ -123,9 +137,16 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 static __always_inline void queued_spin_unlock(struct qspinlock *lock)
 {
 	/*
-	 * unlock() needs release semantics:
+	 * Trace and unlock are combined in queued_spin_unlock_traced()
+	 * so the compiler does not need to preserve the lock pointer
+	 * across the function call, avoiding callee-saved register
+	 * save/restore on the hot path.
 	 */
-	smp_store_release(&lock->locked, 0);
+	if (tracepoint_enabled(contended_release)) {
+		queued_spin_unlock_traced(lock);
+		return;
+	}
+	__queued_spin_unlock(lock);
 }
 #endif
 
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index d2ef312a8611..5f7a0fc2b27a 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -90,3 +90,19 @@ void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
 	trace_contention_end(lock, 0);
 }
 EXPORT_SYMBOL(queued_write_lock_slowpath);
+
+void __lockfunc queued_read_unlock_traced(struct qrwlock *lock)
+{
+	if (queued_rwlock_is_contended(lock))
+		trace_contended_release(lock);
+	__queued_read_unlock(lock);
+}
+EXPORT_SYMBOL(queued_read_unlock_traced);
+
+void __lockfunc queued_write_unlock_traced(struct qrwlock *lock)
+{
+	if (queued_rwlock_is_contended(lock))
+		trace_contended_release(lock);
+	__queued_write_unlock(lock);
+}
+EXPORT_SYMBOL(queued_write_unlock_traced);
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index af8d122bb649..1544dcec65fa 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -104,6 +104,14 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
 #endif
 
+void __lockfunc queued_spin_unlock_traced(struct qspinlock *lock)
+{
+	if (queued_spin_is_contended(lock))
+		trace_contended_release(lock);
+	__queued_spin_unlock(lock);
+}
+EXPORT_SYMBOL(queued_spin_unlock_traced);
+
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
 /**
-- 
2.52.0

