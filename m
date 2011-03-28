From: liqin.chen@sunplusct.com
Subject: [GIT PULL] score arch fixes for 2.6.39
Date: Mon, 28 Mar 2011 15:11:39 +0800
Message-ID: <OFFB188476.85B76899-ON48257861.00264A49-48257861.002784C6@sunplusct.com>
References: <20110325141528.825456671@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mswedge2.sunplus.com ([124.219.29.227]:54039 "EHLO
	mswedge2.sunplus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab1C1H1Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2011 03:27:25 -0400
In-Reply-To: <20110325141528.825456671@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

Hi Linus,

Please pull score arch fixes for Linux 2.6.39.
It's include some fixed for score irq files.

Thanks
--liqin

------

The following changes since commit 
16c29dafcc86024048f1dbb8349d31cb22c7c55a:
  Linus Torvalds (1):
        Merge branch 'syscore' of 
git://git.kernel.org/.../rafael/suspend-2.6

are available in the git repository at:

  git://gitserver.sunplusct.com/linux-2.6-score.git for-linus

Chen Liqin (1):
      score: lost a semicolon in asm/irqflags.h

Thomas Gleixner (4):
      score: Convert irq_chip to new functions
      score: Select GENERIC_HARDIRQS_NO_DEPRECATED
      score: Convert to new irq function names
      score: Use generic show_interrupts()

 arch/score/Kconfig                |    2 +
 arch/score/include/asm/irqflags.h |    2 +-
 arch/score/kernel/irq.c           |   53 
+++++-------------------------------
 3 files changed, 11 insertions(+), 46 deletions(-)
