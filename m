Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:21968 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeGSKJo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jul 2018 06:09:44 -0400
Date: Thu, 19 Jul 2018 11:26:17 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 0/2] add ISO7816 support
Message-ID: <20180719092617.ubfh45wffjqqkt4e@M43218.corp.atmel.com>
References: <20180719084737.1490-1-ludovic.desroches@microchip.com>
 <034fe4ed-979b-51ee-db7c-5dc7137b98e5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <034fe4ed-979b-51ee-db7c-5dc7137b98e5@baylibre.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@bootlin.com, arnd@arndb.de, richard.genoud@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com
Message-ID: <20180719092617.mk2L4kLGKYybjSfC3JGUBXO2dW8LJ6hrZBSEwJRjDoU@z>

Hi Neil,

On Thu, Jul 19, 2018 at 10:59:47AM +0200, Neil Armstrong wrote:
> Hi Ludovic,
> 
> On 19/07/2018 10:47, Ludovic Desroches wrote:
> > Hi,
> > 
> > This patchset adds support for the ISO7816 standard. The USART devices in
> > Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
> > the CLK and I/O signals of a smart card.
> 
> Wow, I would have loved to have this at the time...
> I'm curious, do you have an example of userspace code using this ?
> The ATR rx needs a very weird handling, I'm curious how you managed it.
> 

Unfortunately, I have nothing I can give you at the moment. I am doing
some experiments. Before going further, I need to have the interface
with the kernel accepted.

Of course, I can give more details about the experiments I am doing.
First of all, I am not used to ISO7816 so every feedback are
appreciated.

On the userspace part, there is the PCSC Lite library. It needs a
userspace driver. From what I've seen, most of the readers are managed
by the CCID driver. This driver handle different hardware capabilities.
Some hardware are very close to what we provide with our SoC ie. just
sending the data on the line and not manage the procedure bytes.

The CCID driver includes a lot of things related to the ISO7816 protocol
so I tried to plug my code into it to reuse this code. The issue is that I am
not a CCID device. At the moment, I am writing my own PCSC driver and I am
copying/pasting code I need. The USART only manages the CLK and I/O
signals. Others one are handled by the PCSC driver with the help of
GPIOs.

At a time, I was thinking about a CCID driver (which interprets the CCID
header and interacts with the device handling ISO7816) in the kernel to easily
interface with the PCSC CCID driver but I am not sure it's the right way
to go.

Regards

Ludovic


> Thanks,
> Neil
> 
> > 
> > Changes:
> > - v2
> >   - uart_get_iso7816_config: check there is an iso7816_config function
> >   - use IOCTL macros to generate the IOCTL number
> >   - check that reserved field is not used
> >   - remove debug logs
> >   - check that the iso7816_config is right before doing any action
> >   - change the error from nack and max iteration status to a debug message
> >   - remove patch 3 as it concerns both rs485 and iso7816 to think more
> >   about the need of adding a lock or not
> > 
> > Nicolas Ferre (2):
> >   tty/serial_core: add ISO7816 infrastructure
> >   tty/serial: atmel: add ISO7816 support
> > 
> >  arch/alpha/include/uapi/asm/ioctls.h   |   2 +
> >  arch/mips/include/uapi/asm/ioctls.h    |   2 +
> >  arch/powerpc/include/uapi/asm/ioctls.h |   2 +
> >  arch/sh/include/uapi/asm/ioctls.h      |   2 +
> >  arch/sparc/include/uapi/asm/ioctls.h   |   2 +
> >  arch/xtensa/include/uapi/asm/ioctls.h  |   2 +
> >  drivers/tty/serial/atmel_serial.c      | 170 +++++++++++++++++++++++++++++++--
> >  drivers/tty/serial/atmel_serial.h      |   3 +-
> >  drivers/tty/serial/serial_core.c       |  60 ++++++++++++
> >  include/linux/serial_core.h            |   3 +
> >  include/uapi/asm-generic/ioctls.h      |   2 +
> >  include/uapi/linux/serial.h            |  17 ++++
> >  12 files changed, 256 insertions(+), 11 deletions(-)
> > 
> 
