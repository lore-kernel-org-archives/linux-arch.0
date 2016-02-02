Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58089 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933248AbcBBTxe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Feb 2016 14:53:34 -0500
Subject: [PATCH 2/2] gpio: Remove unused asm/gpio.h files
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 02 Feb 2016 13:53:30 -0600
Message-ID: <20160202195330.10827.68542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <20160202195330.SZgpw2_k0bjklH-fqklZAgChU3YwiX7JmxJnE-6ziNM@z>

asm/gpio.h is included only by linux/gpio.h, and then only when the arch
selects ARCH_HAVE_CUSTOM_GPIO_H.  Only the following arches select it: arm
avr32 blackfin m68k (COLDFIRE only) sh unicore32.

Remove the unused asm/gpio.h files for the arches that do not select
ARCH_HAVE_CUSTOM_GPIO_H.

This is a follow-on to 7563bbf89d06 ("gpiolib/arches: Centralise
bolierplate asm/gpio.h").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/alpha/include/asm/gpio.h      |    4 ----
 arch/ia64/include/asm/gpio.h       |    4 ----
 arch/metag/include/asm/gpio.h      |    4 ----
 arch/microblaze/include/asm/gpio.h |    4 ----
 arch/openrisc/include/asm/gpio.h   |    4 ----
 arch/powerpc/include/asm/gpio.h    |    4 ----
 arch/sparc/include/asm/gpio.h      |    4 ----
 arch/x86/include/asm/gpio.h        |    4 ----
 arch/xtensa/include/asm/gpio.h     |    4 ----
 9 files changed, 36 deletions(-)
 delete mode 100644 arch/alpha/include/asm/gpio.h
 delete mode 100644 arch/ia64/include/asm/gpio.h
 delete mode 100644 arch/metag/include/asm/gpio.h
 delete mode 100644 arch/microblaze/include/asm/gpio.h
 delete mode 100644 arch/openrisc/include/asm/gpio.h
 delete mode 100644 arch/powerpc/include/asm/gpio.h
 delete mode 100644 arch/sparc/include/asm/gpio.h
 delete mode 100644 arch/x86/include/asm/gpio.h
 delete mode 100644 arch/xtensa/include/asm/gpio.h

diff --git a/arch/alpha/include/asm/gpio.h b/arch/alpha/include/asm/gpio.h
deleted file mode 100644
index b3799d8..0000000
--- a/arch/alpha/include/asm/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __LINUX_GPIO_H
-#warning Include linux/gpio.h instead of asm/gpio.h
-#include <linux/gpio.h>
-#endif
diff --git a/arch/ia64/include/asm/gpio.h b/arch/ia64/include/asm/gpio.h
deleted file mode 100644
index b3799d8..0000000
--- a/arch/ia64/include/asm/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __LINUX_GPIO_H
-#warning Include linux/gpio.h instead of asm/gpio.h
-#include <linux/gpio.h>
-#endif
diff --git a/arch/metag/include/asm/gpio.h b/arch/metag/include/asm/gpio.h
deleted file mode 100644
index b3799d8..0000000
--- a/arch/metag/include/asm/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __LINUX_GPIO_H
-#warning Include linux/gpio.h instead of asm/gpio.h
-#include <linux/gpio.h>
-#endif
diff --git a/arch/microblaze/include/asm/gpio.h b/arch/microblaze/include/asm/gpio.h
deleted file mode 100644
index b3799d8..0000000
--- a/arch/microblaze/include/asm/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __LINUX_GPIO_H
-#warning Include linux/gpio.h instead of asm/gpio.h
-#include <linux/gpio.h>
-#endif
diff --git a/arch/openrisc/include/asm/gpio.h b/arch/openrisc/include/asm/gpio.h
deleted file mode 100644
index b3799d8..0000000
--- a/arch/openrisc/include/asm/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __LINUX_GPIO_H
-#warning Include linux/gpio.h instead of asm/gpio.h
-#include <linux/gpio.h>
-#endif
diff --git a/arch/powerpc/include/asm/gpio.h b/arch/powerpc/include/asm/gpio.h
deleted file mode 100644
index b3799d8..0000000
--- a/arch/powerpc/include/asm/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __LINUX_GPIO_H
-#warning Include linux/gpio.h instead of asm/gpio.h
-#include <linux/gpio.h>
-#endif
diff --git a/arch/sparc/include/asm/gpio.h b/arch/sparc/include/asm/gpio.h
deleted file mode 100644
index b3799d8..0000000
--- a/arch/sparc/include/asm/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __LINUX_GPIO_H
-#warning Include linux/gpio.h instead of asm/gpio.h
-#include <linux/gpio.h>
-#endif
diff --git a/arch/x86/include/asm/gpio.h b/arch/x86/include/asm/gpio.h
deleted file mode 100644
index b3799d8..0000000
--- a/arch/x86/include/asm/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __LINUX_GPIO_H
-#warning Include linux/gpio.h instead of asm/gpio.h
-#include <linux/gpio.h>
-#endif
diff --git a/arch/xtensa/include/asm/gpio.h b/arch/xtensa/include/asm/gpio.h
deleted file mode 100644
index b3799d8..0000000
--- a/arch/xtensa/include/asm/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __LINUX_GPIO_H
-#warning Include linux/gpio.h instead of asm/gpio.h
-#include <linux/gpio.h>
-#endif

