Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfJCAKl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:10:41 -0400
Date: Wed, 2 Oct 2019 17:10:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 0/32] Memory-model updates
Message-ID: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20191003001039.raacB9WD6G4orERzQh8MydpclnggP8g-yXvXaIkS7fo@z>

Hello!

This series contains updates for the Linux-kernel memory model:

1.	Fix data race detection for unordered store and load,
	courtesy of Alan Stern.

2-4.	Documentation update for plain accesses.

5-32.	Work-in-progress test-script updates.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |  602 ++++++++++++++++++++++++++++++++++++++++--
 linux-kernel.cat              |    2 
 litmus-tests/.gitignore       |    4 
 scripts/README                |   16 -
 scripts/checkalllitmus.sh     |   29 --
 scripts/checkghlitmus.sh      |   11 
 scripts/checklitmus.sh        |  101 +++----
 scripts/checklitmushist.sh    |    2 
 scripts/checktheselitmus.sh   |   43 +++
 scripts/cmplitmushist.sh      |   53 +++
 scripts/hwfnseg.sh            |   20 +
 scripts/initlitmushist.sh     |    2 
 scripts/judgelitmus.sh        |  164 ++++++++---
 scripts/newlitmushist.sh      |    4 
 scripts/parseargs.sh          |   21 +
 scripts/runlitmus.sh          |  144 +++++++---
 scripts/runlitmushist.sh      |   29 +-
 scripts/simpletest.sh         |   35 ++
 18 files changed, 1071 insertions(+), 211 deletions(-)
