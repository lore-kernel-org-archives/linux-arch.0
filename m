Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5E3EB815;
	Wed, 18 Mar 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859565; cv=none; b=crw44GMJfGfZqekE/FkS0ZwLLFlpPS7/UXk6G5LHMLA5t0XBiVnv3fulN6abPQPEe/tEWAufPnM6fWyqyIa9yUnwG3o0+pPsuhvJj4bPERxwSsSxw2p4L9D/ZyuoOff04boktlZlx4iw6maYkSo1VoAaDdhHLrFx80k7L1YXFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859565; c=relaxed/simple;
	bh=69emOaxLpThjC7Yg1cwTWjaOzWxBNYXsb/jzcLhBkR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSRkYz6OYZVOUhmnzGYTxt6nN+agatU1LdaZ7dAMiyaF2ZOsM03OZPB1jb2LJAm2nCtjYAmMD9S9BVkvyGJQHncMUc8APk4u/OSPnAH54A4Bma1zqiilZOupCg7qOMXkKYaQlBaPIUlZilBSs8pJksbmQhn/CN78ysMR+UX1Irc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=N+hWuJ1A; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="N+hWuJ1A"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 8C128B3E3C;
	Wed, 18 Mar 2026 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773859553;
	bh=ezdQ/F1a9PQHRulpi8cke6vRgjLP5GH76Dfq640SPO0=;
	h=From:To:Cc:Subject:Date;
	b=N+hWuJ1Aufm8nD8KZtt4ROPvMhpSNIEkP0Wuc0uMViH2juxUYlJhklH8g6KfKRHgE
	 W/j/HPfNThDJweibRwtpH8yaOncNtCRkYmnMNQHg2or7mCFkfzxSdvNNINJXo89LXb
	 KOsHJPi4YlfbnZN4cT5x8v6+YB2WH1bBjr7YrXSc=
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
Subject: [PATCH v3 0/4] locking: contended_release tracepoint instrumentation
Date: Wed, 18 Mar 2026 18:45:17 +0000
Message-ID: <cover.1773858853.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing contention_begin/contention_end tracepoints fire on the
waiter side. The lock holder's identity and stack can be captured at
contention_begin time (e.g. perf lock contention --lock-owner), but
this reflects the holder's state when a waiter arrives, not when the
lock is actually released.

This series adds a contended_release tracepoint that fires on the
holder side when a lock with waiters is released. This provides:

- Hold time estimation: when the holder's own acquisition was
  contended, its contention_end (acquisition) and contended_release
  can be correlated to measure how long the lock was held under
  contention.

- The holder's stack at release time, which may differ from what perf lock
  contention --lock-owner captures if the holder does significant work between
  the waiter's arrival and the unlock.

The series is structured as follows:

1. Remove unnecessary linux/sched.h include from trace/events/lock.h.
2. Extract __percpu_up_read() out of the inline percpu_up_read() to
   avoid binary size increase from adding a tracepoint.
3. Add contended_release tracepoint and instrument sleepable locks:
   mutex, rtmutex, semaphore, rwsem, percpu-rwsem, and rwbase_rt.
4. RFC. Extend contended_release to queued spinlocks and queued rwlocks.

v2 -> v3:

- Added new patch: extend contended_release tracepoint to queued spinlocks
  and queued rwlocks (marked as RFC, requesting feedback). This is prompted by
  Matthew Wilcox's suggestion to try to come up with generic instrumentation,
  instead of instrumenting each "special" lock manually. See [1] for the
  discussion.
- Reworked tracepoint placement to fire before the lock is released and
  before the waiter is woken where possible, for consistency with
  spinning locks where there is no explicit wake (inspired by Usama Arif's
  suggestion).
- Remove unnecessary linux/sched.h include from trace/events/lock.h.

RFC -> v2:

- Add trace_contended_release_enabled() guard before waiter checks that
  exist only for the tracepoint (Steven Rostedt).
- Rename __percpu_up_read_slowpath() to __percpu_up_read() (Peter
  Zijlstra).
- Add extern for __percpu_up_read() (Peter Zijlstra).
- Squashed tracepoint introduction and usage commits (Masami Hiramatsu).

v2: https://lore.kernel.org/all/cover.1773164180.git.d@ilvokhin.com/
RFC: https://lore.kernel.org/all/cover.1772642407.git.d@ilvokhin.com/

[1]: https://lore.kernel.org/all/aa7G1nD7Rd9F4eBH@casper.infradead.org/

Dmitry Ilvokhin (4):
  tracing/lock: Remove unnecessary linux/sched.h include
  locking/percpu-rwsem: Extract __percpu_up_read()
  locking: Add contended_release tracepoint to sleepable locks
  locking: Add contended_release tracepoint to spinning locks

 include/asm-generic/qrwlock.h   | 48 +++++++++++++++++++++++++++------
 include/asm-generic/qspinlock.h | 25 +++++++++++++++--
 include/linux/percpu-rwsem.h    | 15 +++--------
 include/trace/events/lock.h     | 18 ++++++++++++-
 kernel/locking/mutex.c          |  3 +++
 kernel/locking/percpu-rwsem.c   | 22 +++++++++++++++
 kernel/locking/qrwlock.c        | 16 +++++++++++
 kernel/locking/qspinlock.c      |  8 ++++++
 kernel/locking/rtmutex.c        |  1 +
 kernel/locking/rwbase_rt.c      |  8 +++++-
 kernel/locking/rwsem.c          |  9 +++++--
 kernel/locking/semaphore.c      |  4 ++-
 12 files changed, 150 insertions(+), 27 deletions(-)

-- 
2.52.0

