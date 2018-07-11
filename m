From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 0/3] add ISO7816 support
Date: Wed, 11 Jul 2018 15:16:35 +0200
Message-ID: <20180711131638.12622-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-arch.vger.kernel.org

Hi,

This set of patches adds support for the ISO7816 standard. The USART devices in
Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
the CLK and I/O signals of a smart card.

Nicolas Ferre (3):
  tty/serial_core: add ISO7816 infrastructure
  tty/serial: atmel: add ISO7816 support
  tty/serial: atmel: manage shutdown in case of RS485 or ISO7816 mode

 drivers/tty/serial/atmel_serial.c | 179 +++++++++++++++++++++++++++++++++++---
 drivers/tty/serial/atmel_serial.h |   3 +-
 drivers/tty/serial/serial_core.c  |  49 +++++++++++
 include/linux/serial_core.h       |   3 +
 include/uapi/asm-generic/ioctls.h |   2 +
 include/uapi/linux/serial.h       |  17 ++++
 6 files changed, 241 insertions(+), 12 deletions(-)

-- 
2.12.2
