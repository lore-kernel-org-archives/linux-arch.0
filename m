From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v4 0/2] add ISO7816 support
Date: Thu, 6 Sep 2018 15:42:12 +0200
Message-ID: <20180906134214.29031-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-arch.vger.kernel.org

Hi,

This patchset adds support for the ISO7816 standard. The USART devices in
Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
the CLK and I/O signals of a smart card.

Changes:
- v4
  - use the IP version number instead of the compatible string to set
  min and max values for fidi.
  - remove a useless macro for fidi.
- v3
  - add IOCTLs to parisc arch.
  - rework atmel_config_iso7816 according to the comments by Richard.
  - keep max iteration hard coded. Will see later if the user need to set
  this value. It may also concern the normal/inverse mode.
  - improve the checking of the value from the user space.
- v2
  - uart_get_iso7816_config: check there is an iso7816_config function.
  - use IOCTL macros to generate the IOCTL number.
  - check that reserved field is not used.
  - remove debug logs.
  - check that the iso7816_config is right before doing any action.
  - change the error from nack and max iteration status to a debug message.
  - remove patch 3 as it concerns both rs485 and iso7816 to think more.
  about the need of adding a lock or not.

Nicolas Ferre (2):
  tty/serial_core: add ISO7816 infrastructure
  tty/serial: atmel: add ISO7816 support

 arch/alpha/include/uapi/asm/ioctls.h   |   2 +
 arch/mips/include/uapi/asm/ioctls.h    |   2 +
 arch/parisc/include/uapi/asm/ioctls.h  |   2 +
 arch/powerpc/include/uapi/asm/ioctls.h |   2 +
 arch/sh/include/uapi/asm/ioctls.h      |   2 +
 arch/sparc/include/uapi/asm/ioctls.h   |   2 +
 arch/xtensa/include/uapi/asm/ioctls.h  |   2 +
 drivers/tty/serial/atmel_serial.c      | 190 +++++++++++++++++++++++++++++++--
 drivers/tty/serial/atmel_serial.h      |   3 +-
 drivers/tty/serial/serial_core.c       |  60 +++++++++++
 include/linux/serial_core.h            |   3 +
 include/uapi/asm-generic/ioctls.h      |   2 +
 include/uapi/linux/serial.h            |  17 +++
 13 files changed, 277 insertions(+), 12 deletions(-)

-- 
2.12.2
