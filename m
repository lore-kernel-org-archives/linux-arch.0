Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:55336 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeLRSyN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Dec 2018 13:54:13 -0500
From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH 0/2] ARC show_regs fixes
Date: Tue, 18 Dec 2018 10:53:57 -0800
Message-ID: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Vineet Gupta <vineet.gupta1@synopsys.com>
Message-ID: <20181218185357.ODbJGavu3hTv10RJIjAnC4SZAabaA6lWpw8VWOo97mc@z>

Vineet Gupta (2):
  ARC: show_regs: avoid page allocator
  ARC: show_regs: fix lockdep splat for good

 arch/arc/kernel/troubleshoot.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
2.7.4
