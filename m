From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 0/4] Documentation/locking/atomic: Add litmus tests for atomic APIs
Date: Wed, 19 Feb 2020 14:26:23 +0800
Message-ID: <20200219062627.104736-1-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43885 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgBSG0n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 01:26:43 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org

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

Changes since v1:

*	Move the tests into Documentation/atomic-tests directory as a
	result of the discussion with Alan and Paul.

*	Word changing on litmus test names and other sentences in
	documents based on Alan's suggestion.

*	Add local variable declarations in 
	Atomic-RMW+mb__after_atomic-is-stronger-than-acquire to make
	klitmus work as per Andrea's suggestion.

Currently, I haven't heard anything from Luc on whether the
atomic_add_unless() works or not for the LKMM, but based on my test and
Andrea's previous test, I think it actually works. I will add the
corresponding changes to the LIMITATIONS part of LKMM document if I got
a comfirm from Luc. And my PR:

	https://github.com/herd/herdtools7/pull/28

is still not merged. So this version is simply an RFC and comments and
suggesions are welcome!

Regards,
Boqun


[1]: http://diy.inria.fr/doc/litmus.html#klitmus

Boqun Feng (4):
  Documentation/locking/atomic: Fix atomic-set litmus test
  Documentation/locking/atomic: Introduce atomic-tests directory
  Documentation/locking/atomic: Add a litmus test for atomic_set()
  Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()

 ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
 ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
 Documentation/atomic-tests/README             | 16 ++++++++++
 Documentation/atomic_t.txt                    | 24 +++++++-------
 MAINTAINERS                                   |  1 +
 5 files changed, 85 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
 create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 create mode 100644 Documentation/atomic-tests/README

-- 
2.25.0
