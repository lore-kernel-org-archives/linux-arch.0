From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 0/6] LKMM updates
Date: Wed, 9 Jan 2019 13:07:06 -0800
Message-ID: <20190109210706.GA27268@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, willy@infradead.org
List-Id: linux-arch.vger.kernel.org

Hello!

This series contains updates for the Linux-kernel memory model:

1-3.	Add SRCU support, courtesy of Alan Stern.

4.	Update README for adding of SRCU support.

5.	Update memory-barriers.txt on enforcing heavy ordering for
	port-I/O accesses, courtesy of Will Deacon.  This one needs
	an ack, preferably by someone from Intel.  Matthew Wilcox
	posted some feedback from an Intel manual here, which might
	be considered to be a close substitute, but...  ;-)

	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org

6.	Update Documentation/explanation.txt to include SRCU support,
	courtesy of Alan Stern.

7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
	Luc Maranget.  This needs an ack.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                |    6 
 tools/memory-model/Documentation/explanation.txt |  289 ++++++++++++-----------
 tools/memory-model/README                        |   25 +
 tools/memory-model/linux-kernel.bell             |   37 ++
 tools/memory-model/linux-kernel.cat              |   55 ++--
 tools/memory-model/linux-kernel.def              |    7 
 6 files changed, 250 insertions(+), 169 deletions(-)
