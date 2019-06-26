From: guoren@kernel.org
Subject: [GIT PULL] csky fixup gcc unwind for v5.2
Date: Wed, 26 Jun 2019 14:14:23 +0800
Message-ID: <1561529663-29852-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Linus,

Only one bugfix for v5.2, please pull.

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.2-fixup-gcc-unwind

for you to fetch changes up to 19e5e2ae9c883f5651eaaeab2f258e2c4b78fda3:

  csky: Fixup libgcc unwind error (2019-06-26 13:45:48 +0800)

----------------------------------------------------------------
arch/csky fixup for 5.2

Only 1 fixup patch for rt_sigframe in signal.c

----------------------------------------------------------------
Guo Ren (1):
      csky: Fixup libgcc unwind error

 arch/csky/kernel/signal.c | 5 +++++
 1 file changed, 5 insertions(+)
