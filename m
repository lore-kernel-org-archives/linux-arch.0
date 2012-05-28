From: Alessandro Rubini <rubini@gnudd.com>
Subject: [PATCH V2 4/6] serial: use the new linux/sizes.h
Date: Mon, 28 May 2012 18:37:48 +0200
Message-ID: <f9488ee124f2101fc284d7375e545e7d96c93f1c.1338222461.git.rubini@gnudd.com>
References: <cover.1338222460.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.gnudd.com ([213.203.150.91]:43137 "EHLO mail.gnudd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892Ab2E1QkE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 May 2012 12:40:04 -0400
Content-Disposition: inline
In-Reply-To: <cover.1338222460.git.rubini@gnudd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org

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
