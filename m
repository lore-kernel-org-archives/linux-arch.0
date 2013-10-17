Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7832 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076Ab3JQRXn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2013 13:23:43 -0400
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 0/3] New descriptor-based GPIO interface
Date: Thu, 17 Oct 2013 10:21:35 -0700
Message-ID: <1382030498-23465-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, gnurou@gmail.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Message-ID: <20131017172135.tdAMmj01MHCuivwZNdUoTRwicWcPjdbGSyN0kh_cphI@z>

Hi Linus,

This version should merge as-is in your tree (I hope!). A patch for
documentation will follow soon.

Changes since v2:
- rebased on top of Linus' for-next branch
- exported new gpiod_(un)lock_as_irq() functions in driver.h
- squashed a fix for a compilation error

Alexandre Courbot (3):
  gpiolib: export descriptor-based GPIO interface
  gpiolib: port of_ functions to use gpiod
  gpiolib: add gpiod_get() and gpiod_put() functions

 drivers/gpio/devres.c         |  83 ++++++
 drivers/gpio/gpiolib-of.c     |  28 +-
 drivers/gpio/gpiolib.c        | 623 +++++++++++++++++++++++++++++-------------
 include/asm-generic/gpio.h    | 222 +++++----------
 include/linux/gpio.h          |  11 +-
 include/linux/gpio/consumer.h | 253 +++++++++++++++++
 include/linux/gpio/driver.h   | 183 +++++++++++++
 include/linux/of_gpio.h       |  29 +-
 8 files changed, 1055 insertions(+), 377 deletions(-)
 create mode 100644 include/linux/gpio/consumer.h
 create mode 100644 include/linux/gpio/driver.h

-- 
1.8.4

