From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 0/2] tools/memory-model: Trivialities
Date: Tue, 19 Feb 2019 23:55:21 +0100
Message-ID: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

Fixes to inline comments, documentation, script usage.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>

Andrea Parri (2):
  tools/memory-model: Fix comment in MP+poonceonces.litmus
  tools/memory-model: Do not use "herd" to refer to "herd7"

 tools/memory-model/litmus-tests/MP+poonceonces.litmus | 2 +-
 tools/memory-model/litmus-tests/README                | 2 +-
 tools/memory-model/lock.cat                           | 2 +-
 tools/memory-model/scripts/README                     | 4 ++--
 tools/memory-model/scripts/checkalllitmus.sh          | 2 +-
 tools/memory-model/scripts/checklitmus.sh             | 2 +-
 tools/memory-model/scripts/parseargs.sh               | 2 +-
 tools/memory-model/scripts/runlitmushist.sh           | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.7.4
