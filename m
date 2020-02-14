Return-Path: <SRS0=xqSd=4C=vger.kernel.org=linux-doc-owner@kernel.org>
From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 1/3] Documentation/locking/atomic: Fix atomic-set litmus test
Date: Fri, 14 Feb 2020 12:01:30 +0800
Message-ID: <20200214040132.91934-2-boqun.feng@gmail.com>
In-Reply-To: <20200214040132.91934-1-boqun.feng@gmail.com>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200214040130.3lps1uxvSU15Jj1XonpSKU9GXxzYn6pQrPrMR6pVQHg@z>

Currently the litmus test "atomic-set" in atomic_t.txt has a few things
to be improved:

1)	The CPU/Processor numbers "P1,P2" are not only inconsistent with
	the rest of the document, which uses "CPU0" and "CPU1", but also
	unacceptable by the herd tool, which requires processors start
	at "P0".

2)	The initialization block uses a "atomic_set()", which is OK, but
	it's better to use ATOMIC_INIT() to make clear this is an
	initialization.

3)	The return value of atomic_add_unless() is discarded
	inexplicitly, which is OK for C language, but it will be helpful
	to the herd tool if we use a void cast to make the discard
	explicit.

Therefore fix these and this is the preparation for adding the litmus
test into memory-model litmus-tests directory so that people can
understand better about our requirements of atomic APIs and klitmus tool
can be used to generate tests.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/atomic_t.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 0ab747e0d5ac..ceb85ada378e 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -91,15 +91,15 @@ ops. That is:
   C atomic-set
 
   {
-    atomic_set(v, 1);
+    atomic_t v = ATOMIC_INIT(1);
   }
 
-  P1(atomic_t *v)
+  P0(atomic_t *v)
   {
-    atomic_add_unless(v, 1, 0);
+    (void)atomic_add_unless(v, 1, 0);
   }
 
-  P2(atomic_t *v)
+  P1(atomic_t *v)
   {
     atomic_set(v, 0);
   }
-- 
2.25.0
