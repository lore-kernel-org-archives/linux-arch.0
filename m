From: Guo Ren <ren_guo@c-sky.com>
Subject: [GIT PULL] C-SKY update for 4.20-rc6
Date: Thu,  6 Dec 2018 13:32:58 +0800
Message-ID: <1544074378-5878-1-git-send-email-ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, guoren@kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Linus,

Please pull.

Best Regards
 Guo Ren

------------------------------------------>
The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-4.20-rc6

for you to fetch changes up to 63e19c8216bb03a1b4d10f6637d1324ae7a2b612:

  csky: bugfix tlb_get_pgd error. (2018-12-03 10:49:11 +0800)

----------------------------------------------------------------
C-SKY fixes/update for 4.20-rc6

 - Bugfix tlb_get_pgd error.

 - Update MAINTAINERS file for C-SKY drivers.

----------------------------------------------------------------
Guo Ren (2):
      MAINTAINERS: add maintainer for C-SKY drivers
      csky: bugfix tlb_get_pgd error.

 MAINTAINERS                         | 7 ++++++-
 arch/csky/include/asm/mmu_context.h | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)
