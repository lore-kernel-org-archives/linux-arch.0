Return-Path: <SRS0=xqSd=4C=vger.kernel.org=linux-doc-owner@kernel.org>
From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Date: Fri, 14 Feb 2020 12:01:29 +0800
Message-ID: <20200214040132.91934-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200214040129.Z-GaoWTh3gNaNvpPuQ3Vtd_cH39HEsvi6BHGIKWdfu8@z>

A recent discussion raises up the requirement for having test cases for
atomic APIs:

	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/

, and since we already have a way to generate a test module from a
litmus test with klitmus[1]. It makes sense that we add more litmus
tests for atomic APIs into memory-model.

So I begin to do this and the plan is to add the litmus tests we already
use in atomic_t.txt, ones from Paul's litmus collection[2], and any
other valuable litmus test we come up while adding the previous two
kinds of tests.

This patchset finishes the first part (adding atomic_t.txt litmus
tests). I also improve the atomic_t.txt to make it consistent with the
litmus tests.

One thing to note is patch #2 requires a modification to herd and I just
made a PR to Luc's repo:

	https://github.com/herd/herdtools7/pull/28

, so if this patchset looks good to everyone and someone plans to take
it (and I assume is Paul), please wait until that PR is settled. And
probably we need to bump the required herd version because of it.

Comments and suggesions are welcome!

Regards,
Boqun


[1]: http://diy.inria.fr/doc/litmus.html#klitmus
[2]: https://github.com/paulmckrcu/litmus/tree/master/manual/atomic

*** BLURB HERE ***

Boqun Feng (3):
  Documentation/locking/atomic: Fix atomic-set litmus test
  tools/memory-model: Add a litmus test for atomic_set()
  tools/memory-model: Add litmus test for RMW + smp_mb__after_atomic()

 Documentation/atomic_t.txt                    | 14 ++++-----
 ...+mb__after_atomic-is-strong-acquire.litmus | 29 +++++++++++++++++++
 .../Atomic-set-observable-to-RMW.litmus       | 24 +++++++++++++++
 tools/memory-model/litmus-tests/README        |  8 +++++
 4 files changed, 68 insertions(+), 7 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
 create mode 100644 tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus

-- 
2.25.0
