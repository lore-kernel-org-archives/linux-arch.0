From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: LKMM email introduction
Date: Mon, 4 Nov 2019 08:46:10 -0800
Message-ID: <20191104164610.GA5997@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: michalis@mpi-sws.org, viktor@mpi-sws.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Michalis and Viktor are interested in implementing LKMM (or some
approximation thereof) in their tool, and are therefore interested in
locating the relevant litmus tests.  They already know about these:

1) https://github.com/paulmckrcu/litmus
2)    https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/tools/memory-model/litmus-tests?h=dev
3) http://diy.inria.fr/linux

Are there any additional existing litmus tests that they should be using?

								Thanx, Paul
