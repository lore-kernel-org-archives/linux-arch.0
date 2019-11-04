Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfKDQqN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Nov 2019 11:46:13 -0500
Date: Mon, 4 Nov 2019 08:46:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: LKMM email introduction
Message-ID: <20191104164610.GA5997@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michalis@mpi-sws.org, viktor@mpi-sws.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20191104164610.mbOCk40OZMd2qldp5r10u2avd3Qfqt2weKeRInoUdec@z>

Michalis and Viktor are interested in implementing LKMM (or some
approximation thereof) in their tool, and are therefore interested in
locating the relevant litmus tests.  They already know about these:

1) https://github.com/paulmckrcu/litmus
2)    https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/tools/memory-model/litmus-tests?h=dev
3) http://diy.inria.fr/linux

Are there any additional existing litmus tests that they should be using?

								Thanx, Paul
