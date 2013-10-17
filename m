From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 0/3] New descriptor-based GPIO interface
Date: Thu, 17 Oct 2013 10:21:35 -0700
Message-ID: <1382030498-23465-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
