From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/4] ARC fixes for 3.12-rc3
Date: Fri, 27 Sep 2013 16:27:33 +0530
Message-ID: <1380279457-14299-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: arc-linux-dev@synopsys.com, u.kleine-koenig@pengutronix.de, Noam Camus <noamc@ezchip.com>, Gilad Ben-Yossef <gilad@benyossef.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

ARC fixes for 3.12-rc3.

Thx,
-Vineet

Mischa Jonker (1):
  ARC: Handle zero-overhead-loop in unaligned access handler

Uwe Kleine-K=C3=B6nig (1):
  ARC: Use clockevents_config_and_register over
    clockevents_register_device

Vineet Gupta (2):
  ARC: Fix 32-bit wrap around in access_ok()
  ARC: Workaround spinlock livelock in SMP SystemC simulation

 arch/arc/include/asm/spinlock.h | 9 ++++++++-
 arch/arc/include/asm/uaccess.h  | 4 ++--
 arch/arc/kernel/time.c          | 7 ++-----
 arch/arc/kernel/unaligned.c     | 6 ++++++
 4 files changed, 18 insertions(+), 8 deletions(-)

--=20
1.8.1.2
