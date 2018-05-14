From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 19/19] tools/memory-model: Add reference for 'Simplifying ARM concurrency'
Date: Mon, 14 May 2018 16:33:57 -0700
Message-ID: <1526340837-12222-19-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

The paper discusses the revised ARMv8 memory model; such revision
had an important impact on the design of the LKMM.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/references.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index 74f448f2616a..b177f3e4a614 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.txt
@@ -63,6 +63,12 @@ o	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
 	Principles of Programming Languages (POPL 2017). ACM, New York,
 	NY, USA, 429–442.
 
+o	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
+	Susmit Sarkar, and Peter Sewell. 2018. "Simplifying ARM concurrency:
+	multicopy-atomic axiomatic and operational models for ARMv8". In
+	Proceedings of the ACM on Programming Languages, Volume 2, Issue
+	POPL, Article No. 19. ACM, New York, NY, USA.
+
 
 Linux-kernel memory model
 =========================
-- 
2.5.2
