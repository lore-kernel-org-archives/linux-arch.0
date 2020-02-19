From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 2/4] Documentation/locking/atomic: Introduce atomic-tests directory
Date: Wed, 19 Feb 2020 14:26:25 +0800
Message-ID: <20200219062627.104736-3-boqun.feng@gmail.com>
References: <20200219062627.104736-1-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200219062627.104736-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Although we have atomic_t.txt and its friends to describe the semantics
of atomic APIs and lib/atomic64_test.c for build testing and testing in
UP mode, the tests for our atomic APIs in real SMP mode are still
missing. Since now we have the LKMM tool in kernel and litmus tests can
be used to generate kernel modules for testing purpose with "klitmus" (a
tool from the LKMM toolset), it makes sense to put a few typical litmus
tests into kernel so that

1)	they are the examples to describe the conceptual mode of the
	semantics of atomic APIs, and

2)	they can be used to generate kernel test modules for anyone
	who is interested to test the atomic APIs implementation (in
	most cases, is the one who implements the APIs for a new arch)

Therefore, introduce the atomic-tests directory for this purpose. The
directory is maintained by the LKMM group to make sure the litmus tests
are always aligned with our memory model.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/atomic-tests/README | 4 ++++
 MAINTAINERS                       | 1 +
 2 files changed, 5 insertions(+)
 create mode 100644 Documentation/atomic-tests/README

diff --git a/Documentation/atomic-tests/README b/Documentation/atomic-tests/README
new file mode 100644
index 000000000000..ae61201a4271
--- /dev/null
+++ b/Documentation/atomic-tests/README
@@ -0,0 +1,4 @@
+This directory contains litmus tests that are typical to describe the semantics
+of our atomic APIs. For more information about how to "run" a litmus test or
+how to generate a kernel test module based on a litmus test, please see
+tools/memory-model/README.
diff --git a/MAINTAINERS b/MAINTAINERS
index ffc7d5712735..ebca5f6263bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9718,6 +9718,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	tools/memory-model/
 F:	Documentation/atomic_bitops.txt
 F:	Documentation/atomic_t.txt
+F:	Documentation/atomic-tests/
 F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
 F:	Documentation/memory-barriers.txt
-- 
2.25.0
