From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/3] New descriptor-based GPIO interface
Date: Fri, 11 Oct 2013 11:14:30 -0700
Message-ID: <1381515273-25466-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15702 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab3JKSOx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2013 14:14:53 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, gnurou@gmail.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>

Hi Linus,

Hopefully this version should compile nicely in all cases. It also improves
inline documentation, but more work is needed for the GPIO guide in
Documentation/. This should follow shortly.

I prefer to send it as-is as other patches started depending on this series and
I guess you don't want them to accumulate too much. :)

Changes since v1:
- added missing definitions of devm_* functions in devres.c
- added missing export of gpiod_get_index()
- added inline documentation for gpiod_* functions
- reorganized consumer.h and added missing functions declarations

Alexandre Courbot (3):
  gpiolib: export descriptor-based GPIO interface
  gpiolib: port of_ functions to use gpiod
  gpiolib: add gpiod_get() and gpiod_put() functions

 drivers/gpio/devres.c         |  83 ++++++
 drivers/gpio/gpiolib-of.c     |  28 +-
 drivers/gpio/gpiolib.c        | 613 +++++++++++++++++++++++++++++-------------
 include/asm-generic/gpio.h    | 222 +++++----------
 include/linux/gpio.h          |  11 +-
 include/linux/gpio/consumer.h | 253 +++++++++++++++++
 include/linux/gpio/driver.h   | 179 ++++++++++++
 include/linux/of_gpio.h       |  29 +-
 8 files changed, 1046 insertions(+), 372 deletions(-)
 create mode 100644 include/linux/gpio/consumer.h
 create mode 100644 include/linux/gpio/driver.h

-- 
1.8.4
