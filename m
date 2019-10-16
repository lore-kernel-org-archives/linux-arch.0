Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56909 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391786AbfJPIl1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 04:41:27 -0400
Received: by mail-qk1-f202.google.com with SMTP id b29so2004659qka.23
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 01:41:25 -0700 (PDT)
Date: Wed, 16 Oct 2019 10:39:56 +0200
In-Reply-To: <20191016083959.186860-1-elver@google.com>
Message-ID: <20191016083959.186860-6-elver@google.com>
Mime-Version: 1.0
References: <20191016083959.186860-1-elver@google.com>
Subject: [PATCH 5/8] seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Message-ID: <20191016083956.Re264eZXyhxhCiqPbt2pJ6sb02ENU__-41oVCnzhzXs@z>

This patch proposes to require marked atomic accesses surrounding
raw_write_seqcount_barrier. We reason that otherwise there is no way to
guarantee propagation nor atomicity of writes before/after the barrier
[1]. For example, consider the compiler tears stores either before or
after the barrier; in this case, readers may observe a partial value,
and because readers are unaware that writes are going on (writes are not
in a seq-writer critical section), will complete the seq-reader critical
section while having observed some partial state.
[1] https://lwn.net/Articles/793253/

This came up when designing and implementing KCSAN, because KCSAN would
flag these accesses as data-races. After careful analysis, our reasoning
as above led us to conclude that the best thing to do is to propose an
amendment to the raw_seqcount_barrier usage.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/seqlock.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 1e425831a7ed..5d50aad53b47 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -265,6 +265,13 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  * usual consistency guarantee. It is one wmb cheaper, because we can
  * collapse the two back-to-back wmb()s.
  *
+ * Note that, writes surrounding the barrier should be declared atomic (e.g.
+ * via WRITE_ONCE): a) to ensure the writes become visible to other threads
+ * atomically, avoiding compiler optimizations; b) to document which writes are
+ * meant to propagate to the reader critical section. This is necessary because
+ * neither writes before and after the barrier are enclosed in a seq-writer
+ * critical section that would ensure readers are aware of ongoing writes.
+ *
  *      seqcount_t seq;
  *      bool X = true, Y = false;
  *
-- 
2.23.0.700.g56cf767bdb-goog
