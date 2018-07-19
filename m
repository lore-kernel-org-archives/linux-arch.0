Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:55602 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeGSJdW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jul 2018 05:33:22 -0400
From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v2 0/2] add ISO7816 support
Date: Thu, 19 Jul 2018 10:47:35 +0200
Message-ID: <20180719084737.1490-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
Message-ID: <20180719084735.zgU2rZE8VwWTFjvRKjcVB3RvMcACekvH3Uet7GwIIos@z>

Hi,

This patchset adds support for the ISO7816 standard. The USART devices in
Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
the CLK and I/O signals of a smart card.

Changes:
- v2
  - uart_get_iso7816_config: check there is an iso7816_config function
  - use IOCTL macros to generate the IOCTL number
  - check that reserved field is not used
  - remove debug logs
  - check that the iso7816_config is right before doing any action
  - change the error from nack and max iteration status to a debug message
  - remove patch 3 as it concerns both rs485 and iso7816 to think more
  about the need of adding a lock or not

Nicolas Ferre (2):
  tty/serial_core: add ISO7816 infrastructure
  tty/serial: atmel: add ISO7816 support

 arch/alpha/include/uapi/asm/ioctls.h   |   2 +
 arch/mips/include/uapi/asm/ioctls.h    |   2 +
 arch/powerpc/include/uapi/asm/ioctls.h |   2 +
 arch/sh/include/uapi/asm/ioctls.h      |   2 +
 arch/sparc/include/uapi/asm/ioctls.h   |   2 +
 arch/xtensa/include/uapi/asm/ioctls.h  |   2 +
 drivers/tty/serial/atmel_serial.c      | 170 +++++++++++++++++++++++++++++++--
 drivers/tty/serial/atmel_serial.h      |   3 +-
 drivers/tty/serial/serial_core.c       |  60 ++++++++++++
 include/linux/serial_core.h            |   3 +
 include/uapi/asm-generic/ioctls.h      |   2 +
 include/uapi/linux/serial.h            |  17 ++++
 12 files changed, 256 insertions(+), 11 deletions(-)

-- 
2.12.2
