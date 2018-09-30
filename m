From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v6 0/4] devres: provide and use devm_kstrdup_const()
Date: Sun, 30 Sep 2018 22:26:11 +0200
Message-ID: <20180930202615.12951-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-arch.vger.kernel.org

This series implements devm_kstrdup_const() together with some
prerequisite changes and uses it in tegra-hsp driver.

v1 -> v2:
- fixed the changelog in the patch implementing devm_kstrdup_const()
- fixed the kernel doc
- moved is_kernel_rodata() to asm-generic/sections.h
- fixed constness

v2 -> v3:
- rebased on top of 4.19-rc5 as there were some conflicts in the
  pmc-atom driver
- collected Reviewed-by tags

v3 -> v4:
- Andy NAK'ed patch 4/4 so I added a different example
- collected more tags

v4 -> v5:
- instead of providing devm_kfree_const(), make devm_kfree() check if
  given pointer is not in .rodata and act accordingly

v5 -> v6:
- fixed the commit message in patch 2/4 (s/devm_kfree_const/devm_kfree/)
- collected even more tags

Bartosz Golaszewski (4):
  devres: constify p in devm_kfree()
  mm: move is_kernel_rodata() to asm-generic/sections.h
  devres: provide devm_kstrdup_const()
  mailbox: tegra-hsp: use devm_kstrdup_const()

 drivers/base/devres.c          | 36 +++++++++++++++++++++++++++--
 drivers/mailbox/tegra-hsp.c    | 41 ++++++++--------------------------
 include/asm-generic/sections.h | 14 ++++++++++++
 include/linux/device.h         |  4 +++-
 mm/util.c                      |  7 ------
 5 files changed, 60 insertions(+), 42 deletions(-)

-- 
2.18.0
