From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 0/7] LKMM updates for v5.1
Date: Wed, 13 Feb 2019 09:36:50 -0800
Message-ID: <20190213173650.GA26078@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

Hello, Ingo,

This series contains updates for the Linux-kernel memory model, which
are ready for inclusion into -tip:

1-5.	Add support for SRCU, courtesy of Alan Stern.

6.	Dynamically check SRCU lock-to-unlock matching, courtesy of
	Luc Maranget.

7.	Avoid duplicating herdtools versions in documentation, courtesy
	of Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |  289 ++++++++++++++++++++++--------------------
 README                        |   33 ++++
 linux-kernel.bell             |   37 ++++-
 linux-kernel.cat              |   57 +++++---
 linux-kernel.def              |    7 -
 lock.cat                      |    3 
 6 files changed, 254 insertions(+), 172 deletions(-)
