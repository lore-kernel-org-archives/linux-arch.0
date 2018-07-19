From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/2] add ISO7816 support
Date: Thu, 19 Jul 2018 10:59:47 +0200
Message-ID: <034fe4ed-979b-51ee-db7c-5dc7137b98e5@baylibre.com>
References: <20180719084737.1490-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719084737.1490-1-ludovic.desroches@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: alexandre.belloni@bootlin.com, arnd@arndb.de, richard.genoud@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com
List-Id: linux-arch.vger.kernel.org

Hi Ludovic,

On 19/07/2018 10:47, Ludovic Desroches wrote:
> Hi,
> 
> This patchset adds support for the ISO7816 standard. The USART devices in
> Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
> the CLK and I/O signals of a smart card.

Wow, I would have loved to have this at the time...
I'm curious, do you have an example of userspace code using this ?
The ATR rx needs a very weird handling, I'm curious how you managed it.

Thanks,
Neil

> 
> Changes:
> - v2
>   - uart_get_iso7816_config: check there is an iso7816_config function
>   - use IOCTL macros to generate the IOCTL number
>   - check that reserved field is not used
>   - remove debug logs
>   - check that the iso7816_config is right before doing any action
>   - change the error from nack and max iteration status to a debug message
>   - remove patch 3 as it concerns both rs485 and iso7816 to think more
>   about the need of adding a lock or not
> 
> Nicolas Ferre (2):
>   tty/serial_core: add ISO7816 infrastructure
>   tty/serial: atmel: add ISO7816 support
> 
>  arch/alpha/include/uapi/asm/ioctls.h   |   2 +
>  arch/mips/include/uapi/asm/ioctls.h    |   2 +
>  arch/powerpc/include/uapi/asm/ioctls.h |   2 +
>  arch/sh/include/uapi/asm/ioctls.h      |   2 +
>  arch/sparc/include/uapi/asm/ioctls.h   |   2 +
>  arch/xtensa/include/uapi/asm/ioctls.h  |   2 +
>  drivers/tty/serial/atmel_serial.c      | 170 +++++++++++++++++++++++++++++++--
>  drivers/tty/serial/atmel_serial.h      |   3 +-
>  drivers/tty/serial/serial_core.c       |  60 ++++++++++++
>  include/linux/serial_core.h            |   3 +
>  include/uapi/asm-generic/ioctls.h      |   2 +
>  include/uapi/linux/serial.h            |  17 ++++
>  12 files changed, 256 insertions(+), 11 deletions(-)
> 
