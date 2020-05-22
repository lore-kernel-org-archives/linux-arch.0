From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Some -serious- BPF-related litmus tests
Date: Thu, 21 May 2020 17:38:50 -0700
Message-ID: <20200522003850.GA32698@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgEVAiv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 20:38:51 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andriin@fb.com

Hello!

Just wanted to call your attention to some pretty cool and pretty serious
litmus tests that Andrii did as part of his BPF ring-buffer work:

https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/

Thoughts?

							Thanx, Paul
