Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtpcmd0871.aruba.it ([62.149.156.71]:46879 "EHLO
        smtpcmd0871.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIry (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2019 04:47:54 -0400
From: Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH 1/2] tty: add bits to manage multidrop mode
Date: Thu, 12 Sep 2019 10:40:31 +0200
Message-Id: <20190912084032.16927-2-giometti@enneenne.com>
In-Reply-To: <20190912084032.16927-1-giometti@enneenne.com>
References: <20190912084032.16927-1-giometti@enneenne.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Richard Genoud <richard.genoud@gmail.com>, Rodolfo Giometti <giometti@linux.it>, Joshua Henderson <joshua.henderson@microchip.com>

From: Rodolfo Giometti <giometti@linux.it>

Multidrop mode differentiates the data characters and the address
characters. Data is transmitted with the parity bit to 0 and addresses
are transmitted with the parity bit to 1. However this usually slow
down communication by adding a delay between the first byte and the
others.

This patch defines two non-stadard bits PARMD (that enables multidrop)
and SENDA (that marks the next transmitted byte as address) that can
be used to completely remove the delay during transmission by
correctly managing the parity bit generation in hardware.

A simple example code about how to set up it is reported below:

    struct termios term;

    tcgetattr(fd, &term);

    /* Transmission: enable parity multidrop and mark 1st byte as address */
    term.c_cflag |= PARENB | CMSPAR | PARMD | SENDA;
    /* Reception: enable parity multidrop and parity check */
    term.c_iflag |= PARENB | PARMD | INPCK;

    tcsetattr(fd, TCSADRAIN, &term);

After that we can start 9 bits data transmission.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 include/linux/tty.h                 | 2 ++
 include/uapi/asm-generic/termbits.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index bfa4e2ee94a9..66a25294f125 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -168,6 +168,8 @@ struct tty_bufhead {
 #define C_CIBAUD(tty)	_C_FLAG((tty), CIBAUD)
 #define C_CRTSCTS(tty)	_C_FLAG((tty), CRTSCTS)
 #define C_CMSPAR(tty)	_C_FLAG((tty), CMSPAR)
+#define C_PARMD(tty)	_C_FLAG((tty), PARMD)
+#define C_SENDA(tty)	_C_FLAG((tty), SENDA)
 
 #define L_ISIG(tty)	_L_FLAG((tty), ISIG)
 #define L_ICANON(tty)	_L_FLAG((tty), ICANON)
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae89dd..ead5eaebdd3b 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -141,6 +141,8 @@ struct ktermios {
 #define HUPCL	0002000
 #define CLOCAL	0004000
 #define CBAUDEX 0010000
+#define PARMD   040000000
+#define SENDA   0100000000
 #define    BOTHER 0010000
 #define    B57600 0010001
 #define   B115200 0010002
-- 
2.17.1
