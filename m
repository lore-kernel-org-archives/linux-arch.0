From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/2] include/asm-generic: Remove spin_is_locked() comment
Date: Wed,  9 Jan 2019 14:21:43 -0800
Message-ID: <20190109222144.14270-1-paulmck@linux.ibm.com>
References: <20190109222120.GA13904@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109222120.GA13904@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The WARN_ON_SMP() comment header suggests using spin_is_locked() to
check for locks being held.  But these days we prefer lockdep_assert_held(),
so this commit removes that suggestion.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
---
 include/asm-generic/bug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..0e9bd9c83870 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -211,9 +211,6 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 /*
  * WARN_ON_SMP() is for cases that the warning is either
  * meaningless for !SMP or may even cause failures.
- * This is usually used for cases that we have
- * WARN_ON(!spin_is_locked(&lock)) checks, as spin_is_locked()
- * returns 0 for uniprocessor settings.
  * It can also be used with values that are only defined
  * on SMP:
  *
-- 
2.17.1
