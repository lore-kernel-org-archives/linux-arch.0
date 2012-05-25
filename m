Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.gnudd.com ([213.203.150.91]:51494 "EHLO mail.gnudd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933412Ab2EYPsu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 May 2012 11:48:50 -0400
Date: Fri, 25 May 2012 17:48:34 +0200
From: Alessandro Rubini <rubini@gnudd.com>
Subject: [PATCH 4/6] pl011: use the new linux/sizes.h
Message-ID: <eb12b34086d040d4a801a48a44284272cf38975d.1337959750.git.rubini@gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <cover.1337959750.git.rubini@gnudd.com>
In-Reply-To: <cover.1337959750.git.rubini@gnudd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120525154834.ZRlEjdCMuusGx_qGYqmpQ9nSSn7lC_egwmE5x1yh98U@z>

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4ad721f..d394b93 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -53,9 +53,9 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/sizes.h>
 
 #include <asm/io.h>
-#include <asm/sizes.h>
 
 #define UART_NR			14
 
-- 
1.7.7.2
