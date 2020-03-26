From: Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v4 0/4] Documentation/litmus-tests: Add litmus tests for atomic APIs
Date: Thu, 26 Mar 2020 10:40:18 +0800
Message-ID: <20200326024022.7566-1-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Joel Fernandes <joel@joelfernandes.org>linu
List-Id: linux-arch.vger.kernel.org

A recent discussion raises up the requirement for having test cases for
atomic APIs:

	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/

, and since we already have a way to generate a test module from a
litmus test with klitmus[1]. It makes sense that we add more litmus
tests for atomic APIs. And based on the previous discussion, I create a
new directory Documentation/atomic-tests and put these litmus tests
here.

This patchset starts the work by adding the litmus tests which are
already used in atomic_t.txt, and also improve the atomic_t.txt to make
it consistent with the litmus tests.

Previous version:
v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/

Changes since v3:

*	Merge two patches on atomic-set litmus test into one as per
	Alan. (Alan, you have acked only one of the two patches, so I
	don't add you acked-by for the combined patch).

*	Move the atomic litmus tests into litmus-tests/atomic to align
	with Joel's recent patches on RCU litmus tests.

I think we still haven't reach to a conclusion for the difference of
atomic_add_unless() in herdtools, and I'm currently reading the source
code of herd to resovle this. This is just an updated version to resolve
ealier comments and react on Joel's RCU litmus tests.

Regards,
Boqun

[1]: http://diy.inria.fr/doc/litmus.html#klitmus

Boqun Feng (4):
  tools/memory-model: Add an exception for limitations on _unless()
    family
  Documentation/litmus-tests: Introduce atomic directory
  Documentation/litmus-tests/atomic: Add a test for atomic_set()
  Documentation/litmus-tests/atomic: Add a test for
    smp_mb__after_atomic()

 Documentation/atomic_t.txt                    | 24 +++++++-------
 ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
 ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
 Documentation/litmus-tests/atomic/README      | 16 ++++++++++
 tools/memory-model/README                     | 10 ++++--
 5 files changed, 91 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 create mode 100644 Documentation/litmus-tests/atomic/README

-- 
2.25.1
