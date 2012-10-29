From: <gerg@snapgear.com>
Subject: [PATCH v2 00/11] m68k: use asm-generic headers when possible
Date: Mon, 29 Oct 2012 15:49:23 +1000
Message-ID: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Quite a few of the m68k asm headers are identical to the asm-generic
versions. So switch to using them where ever we can.

v2 is rebased on top of 3.7-rc3.

All defconfigs build. Run tested on ColdFire (with and without MMU) and on
ArranyM.

---
 arch/m68k/include/asm/Kbuild          |   11 +
 arch/m68k/include/asm/hw_irq.h        |    6 -
 arch/m68k/include/asm/shmparam.h      |    6 -
 arch/m68k/include/asm/spinlock.h      |    6 -
 arch/m68k/include/asm/termios.h       |   50 --------
 arch/m68k/include/uapi/asm/Kbuild     |    8 -
 arch/m68k/include/uapi/asm/auxvec.h   |    4 
 arch/m68k/include/uapi/asm/msgbuf.h   |   31 -----
 arch/m68k/include/uapi/asm/sembuf.h   |   25 ----
 arch/m68k/include/uapi/asm/shmbuf.h   |   42 -------
 arch/m68k/include/uapi/asm/socket.h   |   72 ------------
 arch/m68k/include/uapi/asm/sockios.h  |   13 --
 arch/m68k/include/uapi/asm/termbits.h |  201 ----------------------------------
 arch/m68k/include/uapi/asm/termios.h  |   44 -------
 14 files changed, 11 insertions(+), 508 deletions(-)
