From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH 4/5] arch/parisc, termios: use <asm-generic/termios.h>
Date: Thu,  4 Oct 2018 15:29:52 -0700
Message-ID: <20181004222953.2229-5-hpa@zytor.com>
References: <20181004222953.2229-1-hpa@zytor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004222953.2229-1-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-serial@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-parisc@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-arch.vger.kernel.org

The PARISC  definition of termbits.h is almost identical to the generic
one, so use the generic one and only redefine a handful of constants.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-parisc@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
---
 arch/parisc/include/uapi/asm/termbits.h | 197 +-------------------------------
 1 file changed, 4 insertions(+), 193 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index 40e920f8d683..28ce9067f2e0 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -2,201 +2,12 @@
 #ifndef __ARCH_PARISC_TERMBITS_H__
 #define __ARCH_PARISC_TERMBITS_H__
 
-#include <linux/posix_types.h>
+#include <asm-generic/termbits.h>
 
-typedef unsigned char	cc_t;
-typedef unsigned int	speed_t;
-typedef unsigned int	tcflag_t;
-
-#define NCCS 19
-struct termios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-};
-
-struct termios2 {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
-struct ktermios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
-/* c_cc characters */
-#define VINTR 0
-#define VQUIT 1
-#define VERASE 2
-#define VKILL 3
-#define VEOF 4
-#define VTIME 5
-#define VMIN 6
-#define VSWTC 7
-#define VSTART 8
-#define VSTOP 9
-#define VSUSP 10
-#define VEOL 11
-#define VREPRINT 12
-#define VDISCARD 13
-#define VWERASE 14
-#define VLNEXT 15
-#define VEOL2 16
-
-
-/* c_iflag bits */
-#define IGNBRK	0000001
-#define BRKINT	0000002
-#define IGNPAR	0000004
-#define PARMRK	0000010
-#define INPCK	0000020
-#define ISTRIP	0000040
-#define INLCR	0000100
-#define IGNCR	0000200
-#define ICRNL	0000400
-#define IUCLC	0001000
-#define IXON	0002000
-#define IXANY	0004000
-#define IXOFF	0010000
+/* c_iflag bits that differ from the generic ABI */
+#undef IMAXBEL
 #define IMAXBEL	0040000
+#undef IUTF8
 #define IUTF8	0100000
 
-/* c_oflag bits */
-#define OPOST	0000001
-#define OLCUC	0000002
-#define ONLCR	0000004
-#define OCRNL	0000010
-#define ONOCR	0000020
-#define ONLRET	0000040
-#define OFILL	0000100
-#define OFDEL	0000200
-#define NLDLY	0000400
-#define   NL0	0000000
-#define   NL1	0000400
-#define CRDLY	0003000
-#define   CR0	0000000
-#define   CR1	0001000
-#define   CR2	0002000
-#define   CR3	0003000
-#define TABDLY	0014000
-#define   TAB0	0000000
-#define   TAB1	0004000
-#define   TAB2	0010000
-#define   TAB3	0014000
-#define   XTABS	0014000
-#define BSDLY	0020000
-#define   BS0	0000000
-#define   BS1	0020000
-#define VTDLY	0040000
-#define   VT0	0000000
-#define   VT1	0040000
-#define FFDLY	0100000
-#define   FF0	0000000
-#define   FF1	0100000
-
-/* c_cflag bit meaning */
-#define CBAUD   0010017
-#define  B0     0000000         /* hang up */
-#define  B50    0000001
-#define  B75    0000002
-#define  B110   0000003
-#define  B134   0000004
-#define  B150   0000005
-#define  B200   0000006
-#define  B300   0000007
-#define  B600   0000010
-#define  B1200  0000011
-#define  B1800  0000012
-#define  B2400  0000013
-#define  B4800  0000014
-#define  B9600  0000015
-#define  B19200 0000016
-#define  B38400 0000017
-#define EXTA B19200
-#define EXTB B38400
-#define CSIZE   0000060
-#define   CS5   0000000
-#define   CS6   0000020
-#define   CS7   0000040
-#define   CS8   0000060
-#define CSTOPB  0000100
-#define CREAD   0000200
-#define PARENB  0000400
-#define PARODD  0001000
-#define HUPCL   0002000
-#define CLOCAL  0004000
-#define CBAUDEX 0010000
-#define    BOTHER 0010000
-#define    B57600 0010001
-#define   B115200 0010002
-#define   B230400 0010003
-#define   B460800 0010004
-#define   B500000 0010005
-#define   B576000 0010006
-#define   B921600 0010007
-#define  B1000000 0010010
-#define  B1152000 0010011
-#define  B1500000 0010012
-#define  B2000000 0010013
-#define  B2500000 0010014
-#define  B3000000 0010015
-#define  B3500000 0010016
-#define  B4000000 0010017
-#define CIBAUD    002003600000		/* input baud rate */
-#define CMSPAR    010000000000          /* mark or space (stick) parity */
-#define CRTSCTS   020000000000          /* flow control */
-
-#define IBSHIFT	16		/* Shift from CBAUD to CIBAUD */
-
-
-/* c_lflag bits */
-#define ISIG    0000001
-#define ICANON  0000002
-#define XCASE   0000004
-#define ECHO    0000010
-#define ECHOE   0000020
-#define ECHOK   0000040
-#define ECHONL  0000100
-#define NOFLSH  0000200
-#define TOSTOP  0000400
-#define ECHOCTL 0001000
-#define ECHOPRT 0002000
-#define ECHOKE  0004000
-#define FLUSHO  0010000
-#define PENDIN  0040000
-#define IEXTEN  0100000
-#define EXTPROC	0200000
-
-/* tcflow() and TCXONC use these */
-#define	TCOOFF		0
-#define	TCOON		1
-#define	TCIOFF		2
-#define	TCION		3
-
-/* tcflush() and TCFLSH use these */
-#define	TCIFLUSH	0
-#define	TCOFLUSH	1
-#define	TCIOFLUSH	2
-
-/* tcsetattr uses these */
-#define	TCSANOW		0
-#define	TCSADRAIN	1
-#define	TCSAFLUSH	2
-
 #endif
-- 
2.14.4
