From: Marco Elver <elver@google.com>
Subject: [PATCH] tools/memory-model/Documentation: Fix "conflict" definition
Date: Fri, 28 Feb 2020 17:46:21 +0100
Message-ID: <20200228164621.87523-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48063 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgB1Qrd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Feb 2020 11:47:33 -0500
Received: by mail-qt1-f202.google.com with SMTP id x8so3374959qtq.14
        for <linux-arch@vger.kernel.org>; Fri, 28 Feb 2020 08:47:33 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com
Cc: paulmck@kernel.org, andreyknvl@google.com, glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, linux-arch@vger.kernel.org

For language-level memory consistency models that are adaptations of
data-race-free, the definition of "data race" can be summarized as
"concurrent conflicting accesses, where at least one is non-sync/plain".

The definition of "conflict" should not include the type of access nor
whether the accesses are concurrent or not, which this patch addresses
for explanation.txt.

The definition of "data race" remains unchanged, but the informal
definition for "conflict" is restored to what can be found in the
literature.

Signed-by: Marco Elver <elver@google.com>
---
 tools/memory-model/Documentation/explanation.txt | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index e91a2eb19592a..11cf89b5b85d9 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1986,18 +1986,15 @@ violates the compiler's assumptions, which would render the ultimate
 outcome undefined.
 
 In technical terms, the compiler is allowed to assume that when the
-program executes, there will not be any data races.  A "data race"
-occurs when two conflicting memory accesses execute concurrently;
-two memory accesses "conflict" if:
+program executes, there will not be any data races. A "data race"
+occurs if:
 
-	they access the same location,
+	two concurrent memory accesses "conflict";
 
-	they occur on different CPUs (or in different threads on the
-	same CPU),
+	and at least one of the accesses is a plain access;
 
-	at least one of them is a plain access,
-
-	and at least one of them is a store.
+	where two memory accesses "conflict" if they access the same
+	memory location, and at least one performs a write;
 
 The LKMM tries to determine whether a program contains two conflicting
 accesses which may execute concurrently; if it does then the LKMM says
-- 
2.25.1.481.gfbce0eb801-goog
