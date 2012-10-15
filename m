Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:28915 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab2JOGqd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 02:46:33 -0400
From: <gerg@snapgear.com>
Subject: [PATCH 00/11] m68k: use asm-generic headers when possible
Date: Mon, 15 Oct 2012 16:49:08 +1000
Message-ID: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20121015064908.oUjXrhPFfmP5yg-o-fZs5AJwpDinbLY4SgO1CxIvI38@z>


On Arnd's suggestion I have gone through the m68k asm headers and weeded
out a bunch that are identical (or near enough) to the asm-generic versions
of these files.

All defconfigs build. Run tested on ColdFire (with and without MMU) and on
ArranyM.

---
 arch/m68k/include/asm/Kbuild     |   11 ++
 arch/m68k/include/asm/auxvec.h   |    4
 arch/m68k/include/asm/hw_irq.h   |    6 -
 arch/m68k/include/asm/msgbuf.h   |   31 ------
 arch/m68k/include/asm/sembuf.h   |   25 ----
 arch/m68k/include/asm/shmbuf.h   |   42 --------
 arch/m68k/include/asm/shmparam.h |    6 -
 arch/m68k/include/asm/socket.h   |   72 -------------
 arch/m68k/include/asm/sockios.h  |   13 --
 arch/m68k/include/asm/spinlock.h |    6 -
 arch/m68k/include/asm/termbits.h |  201 ---------------------------------------
 arch/m68k/include/asm/termios.h  |   92 -----------------
 12 files changed, 11 insertions(+), 498 deletions(-)

