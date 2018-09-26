From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v5 1/2] tty/serial_core: add ISO7816 infrastructure
Date: Wed, 26 Sep 2018 14:58:47 +0200
Message-ID: <20180926125848.31032-2-ludovic.desroches@microchip.com>
References: <20180926125848.31032-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926125848.31032-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-arch.vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add the ISO7816 ioctl and associated accessors and data structure.
Drivers can then use this common implementation to handle ISO7816
(smart cards).

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[ludovic.desroches@microchip.com: squash and rebase, removal of gpios, checkpatch fixes]
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 Documentation/serial/serial-iso7816.txt | 83 +++++++++++++++++++++++++++++++++
 arch/alpha/include/uapi/asm/ioctls.h    |  2 +
 arch/mips/include/uapi/asm/ioctls.h     |  2 +
 arch/parisc/include/uapi/asm/ioctls.h   |  2 +
 arch/powerpc/include/uapi/asm/ioctls.h  |  2 +
 arch/sh/include/uapi/asm/ioctls.h       |  2 +
 arch/sparc/include/uapi/asm/ioctls.h    |  2 +
 arch/xtensa/include/uapi/asm/ioctls.h   |  2 +
 drivers/tty/serial/serial_core.c        | 60 ++++++++++++++++++++++++
 include/linux/serial_core.h             |  3 ++
 include/uapi/asm-generic/ioctls.h       |  2 +
 include/uapi/linux/serial.h             | 17 +++++++
 12 files changed, 179 insertions(+)
 create mode 100644 Documentation/serial/serial-iso7816.txt

diff --git a/Documentation/serial/serial-iso7816.txt b/Documentation/serial/serial-iso7816.txt
new file mode 100644
index 000000000000..3193d24a2b0f
--- /dev/null
+++ b/Documentation/serial/serial-iso7816.txt
@@ -0,0 +1,83 @@
+                        ISO7816 SERIAL COMMUNICATIONS
+
+1. INTRODUCTION
+
+  ISO/IEC7816 is a series of standards specifying integrated circuit cards (ICC)
+  also known as smart cards.
+
+2. HARDWARE-RELATED CONSIDERATIONS
+
+  Some CPUs/UARTs (e.g., Microchip AT91) contain a built-in mode capable of
+  handling communication with a smart card.
+
+  For these microcontrollers, the Linux driver should be made capable of
+  working in both modes, and proper ioctls (see later) should be made
+  available at user-level to allow switching from one mode to the other, and
+  vice versa.
+
+3. DATA STRUCTURES ALREADY AVAILABLE IN THE KERNEL
+
+  The Linux kernel provides the serial_iso7816 structure (see [1]) to handle
+  ISO7816 communications. This data structure is used to set and configure
+  ISO7816 parameters in ioctls.
+
+  Any driver for devices capable of working both as RS232 and ISO7816 should
+  implement the iso7816_config callback in the uart_port structure. The
+  serial_core calls iso7816_config to do the device specific part in response
+  to TIOCGISO7816 and TIOCSISO7816 ioctls (see below). The iso7816_config
+  callback receives a pointer to struct serial_iso7816.
+
+4. USAGE FROM USER-LEVEL
+
+  From user-level, ISO7816 configuration can be get/set using the previous
+  ioctls. For instance, to set ISO7816 you can use the following code:
+
+	#include <linux/serial.h>
+
+	/* Include definition for ISO7816 ioctls: TIOCSISO7816 and TIOCGISO7816 */
+	#include <sys/ioctl.h>
+
+	/* Open your specific device (e.g., /dev/mydevice): */
+	int fd = open ("/dev/mydevice", O_RDWR);
+	if (fd < 0) {
+		/* Error handling. See errno. */
+	}
+
+	struct serial_iso7816 iso7816conf;
+
+	/* Reserved fields as to be zeroed */
+	memset(&iso7816conf, 0, sizeof(iso7816conf));
+
+	/* Enable ISO7816 mode: */
+	iso7816conf.flags |= SER_ISO7816_ENABLED;
+
+	/* Select the protocol: */
+	/* T=0 */
+	iso7816conf.flags |= SER_ISO7816_T(0);
+	/* or T=1 */
+	iso7816conf.flags |= SER_ISO7816_T(1);
+
+	/* Set the guard time: */
+	iso7816conf.tg = 2;
+
+	/* Set the clock frequency*/
+	iso7816conf.clk = 3571200;
+
+	/* Set transmission factors: */
+	iso7816conf.sc_fi = 372;
+	iso7816conf.sc_di = 1;
+
+	if (ioctl(fd_usart, TIOCSISO7816, &iso7816conf) < 0) {
+		/* Error handling. See errno. */
+	}
+
+	/* Use read() and write() syscalls here... */
+
+	/* Close the device when finished: */
+	if (close (fd) < 0) {
+		/* Error handling. See errno. */
+	}
+
+5. REFERENCES
+
+ [1]    include/uapi/linux/serial.h
diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
index 3729d92d3fa8..1e9121c9b3c7 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -102,6 +102,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
index 890245a9f0c4..16aa8a766aec 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -93,6 +93,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 /* I hope the range from 0x5480 on is free ... */
 #define TIOCSCTTY	0x5480		/* become controlling tty */
diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
index aafb1c0ca0af..82d1148c6379 100644
--- a/arch/parisc/include/uapi/asm/ioctls.h
+++ b/arch/parisc/include/uapi/asm/ioctls.h
@@ -62,6 +62,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/include/uapi/asm/ioctls.h
index 41b1a5c15734..2c145da3b774 100644
--- a/arch/powerpc/include/uapi/asm/ioctls.h
+++ b/arch/powerpc/include/uapi/asm/ioctls.h
@@ -102,6 +102,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff --git a/arch/sh/include/uapi/asm/ioctls.h b/arch/sh/include/uapi/asm/ioctls.h
index cc62f6f98103..11866d4f60e1 100644
--- a/arch/sh/include/uapi/asm/ioctls.h
+++ b/arch/sh/include/uapi/asm/ioctls.h
@@ -95,6 +95,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define TIOCSERCONFIG	_IO('T', 83) /* 0x5453 */
 #define TIOCSERGWILD	_IOR('T', 84,  int) /* 0x5454 */
diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 2df52711e170..7fd2f5873c9e 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -27,6 +27,8 @@
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGRS485	_IOR('T', 0x41, struct serial_rs485)
 #define TIOCSRS485	_IOWR('T', 0x42, struct serial_rs485)
+#define TIOCGISO7816	_IOR('T', 0x43, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x44, struct serial_iso7816)
 
 /* Note that all the ioctls that are not available in Linux have a
  * double underscore on the front to: a) avoid some programs to
diff --git a/arch/xtensa/include/uapi/asm/ioctls.h b/arch/xtensa/include/uapi/asm/ioctls.h
index ec43609cbfc5..6d4a87296c95 100644
--- a/arch/xtensa/include/uapi/asm/ioctls.h
+++ b/arch/xtensa/include/uapi/asm/ioctls.h
@@ -107,6 +107,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define TIOCSERCONFIG	_IO('T', 83)
 #define TIOCSERGWILD	_IOR('T', 84,  int)
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 80bb56facfb6..70402cdb4d8c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1308,6 +1308,58 @@ static int uart_set_rs485_config(struct uart_port *port,
 	return 0;
 }
 
+static int uart_get_iso7816_config(struct uart_port *port,
+				   struct serial_iso7816 __user *iso7816)
+{
+	unsigned long flags;
+	struct serial_iso7816 aux;
+
+	if (!port->iso7816_config)
+		return -ENOIOCTLCMD;
+
+	spin_lock_irqsave(&port->lock, flags);
+	aux = port->iso7816;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (copy_to_user(iso7816, &aux, sizeof(aux)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int uart_set_iso7816_config(struct uart_port *port,
+				   struct serial_iso7816 __user *iso7816_user)
+{
+	struct serial_iso7816 iso7816;
+	int i, ret;
+	unsigned long flags;
+
+	if (!port->iso7816_config)
+		return -ENOIOCTLCMD;
+
+	if (copy_from_user(&iso7816, iso7816_user, sizeof(*iso7816_user)))
+		return -EFAULT;
+
+	/*
+	 * There are 5 words reserved for future use. Check that userspace
+	 * doesn't put stuff in there to prevent breakages in the future.
+	 */
+	for (i = 0; i < 5; i++)
+		if (iso7816.reserved[i])
+			return -EINVAL;
+
+	spin_lock_irqsave(&port->lock, flags);
+	ret = port->iso7816_config(port, &iso7816);
+	spin_unlock_irqrestore(&port->lock, flags);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(iso7816_user, &port->iso7816, sizeof(port->iso7816)))
+		return -EFAULT;
+
+	return 0;
+}
+
 /*
  * Called via sys_ioctl.  We can use spin_lock_irq() here.
  */
@@ -1392,6 +1444,14 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	case TIOCSRS485:
 		ret = uart_set_rs485_config(uport, uarg);
 		break;
+
+	case TIOCSISO7816:
+		ret = uart_set_iso7816_config(state->uart_port, uarg);
+		break;
+
+	case TIOCGISO7816:
+		ret = uart_get_iso7816_config(state->uart_port, uarg);
+		break;
 	default:
 		if (uport->ops->ioctl)
 			ret = uport->ops->ioctl(uport, cmd, arg);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 406edae44ca3..047fa67d039b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -144,6 +144,8 @@ struct uart_port {
 	void			(*handle_break)(struct uart_port *);
 	int			(*rs485_config)(struct uart_port *,
 						struct serial_rs485 *rs485);
+	int			(*iso7816_config)(struct uart_port *,
+						  struct serial_iso7816 *iso7816);
 	unsigned int		irq;			/* irq number */
 	unsigned long		irqflags;		/* irq flags  */
 	unsigned int		uartclk;		/* base uart clock */
@@ -260,6 +262,7 @@ struct uart_port {
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
+	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
 
diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
index 040651735662..cdc9f4ca8c27 100644
--- a/include/uapi/asm-generic/ioctls.h
+++ b/include/uapi/asm-generic/ioctls.h
@@ -79,6 +79,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define FIONCLEX	0x5450
 #define FIOCLEX		0x5451
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 3fdd0dee8b41..93eb3c496ff1 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -132,4 +132,21 @@ struct serial_rs485 {
 					   are a royal PITA .. */
 };
 
+/*
+ * Serial interface for controlling ISO7816 settings on chips with suitable
+ * support. Set with TIOCSISO7816 and get with TIOCGISO7816 if supported by
+ * your platform.
+ */
+struct serial_iso7816 {
+	__u32	flags;			/* ISO7816 feature flags */
+#define SER_ISO7816_ENABLED		(1 << 0)
+#define SER_ISO7816_T_PARAM		(0x0f << 4)
+#define SER_ISO7816_T(t)		(((t) & 0x0f) << 4)
+	__u32	tg;
+	__u32	sc_fi;
+	__u32	sc_di;
+	__u32	clk;
+	__u32	reserved[5];
+};
+
 #endif /* _UAPI_LINUX_SERIAL_H */
-- 
2.12.2
