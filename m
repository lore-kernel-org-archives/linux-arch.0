From: <gerg@snapgear.com>
Subject: [PATCH 00/11] m68k: use asm-generic headers when possible
Date: Mon, 15 Oct 2012 16:49:08 +1000
Message-ID: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


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
