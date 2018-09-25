Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54087 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbeIYSyF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Sep 2018 14:54:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so13286403wme.3
        for <linux-arch@vger.kernel.org>; Tue, 25 Sep 2018 05:46:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 0/4] devres: provide and use devm_kstrdup_const()
Date: Tue, 25 Sep 2018 14:46:25 +0200
Message-ID: <20180925124629.20710-1-brgl@bgdev.pl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Arend van Spriel <aspriel@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Vivek Gautam <vivek.gautam@codeaurora.org>, Joe Perches <joe@perches.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>, Huang Ying <ying.huang@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Message-ID: <20180925124625.CXbuaD0kKHZzI5ouM3pKvfXnFoKItz0G2Ti22PJzhiU@z>

This series implements devm_kstrdup_const() together with some
prerequisite changes and uses it in pmc-atom driver.

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

Bartosz Golaszewski (4):
  devres: constify p in devm_kfree()
  mm: move is_kernel_rodata() to asm-generic/sections.h
  devres: provide devm_kstrdup_const()
  mailbox: tegra-hsp: use devm_kstrdup_const()

 drivers/base/devres.c          | 43 ++++++++++++++++++++++++++++++++--
 drivers/mailbox/tegra-hsp.c    | 41 +++++++-------------------------
 include/asm-generic/sections.h | 14 +++++++++++
 include/linux/device.h         |  5 +++-
 mm/util.c                      |  7 ------
 5 files changed, 68 insertions(+), 42 deletions(-)

-- 
2.18.0
