From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 0/12] Reorganize RCU-related cat rules
Date: Fri, 23 Mar 2018 08:46:51 -0700
Message-ID: <20180323154651.GA28363@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: mutt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

Hello!

This patch series reorganizes RCU-related cat-file rules:

1.	Renames link and rcu-path to rcu-link and rb, respectively.
	This avoids unfortunate name collisions with "link" the rule and
	"link" the concept.  Courtesy of Alan Stern.

2.	Redefines "rb" in terms of rcu-fence, explicitly expressing
	the fence-like properties of RCU grace periods.  Courtesy of
	Alan Stern.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |  261 +++++++++++++++++++++++++-----------------
 linux-kernel.cat              |   49 ++++---
 2 files changed, 184 insertions(+), 126 deletions(-)
