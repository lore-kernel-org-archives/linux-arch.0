From: Guo Ren <ren_guo@c-sky.com>
Subject: [GIT PULL] fixup dtb Kbuild for C-SKY(csky) Port
Date: Thu,  1 Nov 2018 13:28:25 +0800
Message-ID: <1541050105-14469-1-git-send-email-ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, robh@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, guoren1983@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Please pull this to fixup dtb Kbuild rules for csky subsystem.

The following changes since commit ac435075892e3e651c667b4a9f2267cf3ef1d5a2:

  Merge tag 'csky-for-linus-4.20' of https://github.com/c-sky/csky-linux (2018-10-29 08:25:00 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-4.20-fixup-dtb

for you to fetch changes up to e8d0c9a726cd1eae410148fcc6a1db23019f0334:

  csky: use common dtb build rules (2018-11-01 10:52:27 +0800)

----------------------------------------------------------------
csky: dtb Kbuild fixup patches for linux-4.20-rc1

These patches are complementary to "C-SKY(csky) Port for Linux 4.20" and
fixup dtb Kbuild to follow the new Devicetree dtb build rules.

Link: https://lore.kernel.org/lkml/CABGGisxiWaQn9qDqpfxEWcckkGJfMzFvSPGvuhQK7oB404-6DQ@mail.gmail.com/
Signed-off-by: Guo Ren <ren_guo@c-sky.com>

----------------------------------------------------------------
Guo Ren (2):
      csky: remove builtin-dtb Kbuild
      csky: use common dtb build rules

 arch/csky/Kconfig.debug     | 10 +---------
 arch/csky/Makefile          | 13 +------------
 arch/csky/boot/dts/Makefile | 10 ----------
 3 files changed, 2 insertions(+), 31 deletions(-)
