From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH 0/2] ARC show_regs fixes
Date: Tue, 18 Dec 2018 10:53:57 -0800
Message-ID: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Vineet Gupta <vineet.gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Vineet Gupta (2):
  ARC: show_regs: avoid page allocator
  ARC: show_regs: fix lockdep splat for good

 arch/arc/kernel/troubleshoot.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
2.7.4
