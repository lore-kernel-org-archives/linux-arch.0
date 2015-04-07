Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:36680 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbbDGRFx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Apr 2015 13:05:53 -0400
Received: by qcgx3 with SMTP id x3so23934270qcg.3
        for <linux-arch@vger.kernel.org>; Tue, 07 Apr 2015 10:05:52 -0700 (PDT)
Message-ID: <55240E63.3040502@hurleysoftware.com>
Date: Tue, 07 Apr 2015 13:05:39 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 10/15] serial: stm32-usart: Add STM32 USART Driver
References: <1428424234-28572-1-git-send-email-mcoquelin.stm32@gmail.com> <1428424234-28572-11-git-send-email-mcoquelin.stm32@gmail.com> <55240B2C.3020102@suse.de>
In-Reply-To: <55240B2C.3020102@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, u.kleine-koenig@pengutronix.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, stefan@agner.ch, pmeerw@pmeerw.net, pebolle@tiscali.nl, andy.shevchenko@gmail.com, cw00.choi@samsung.com, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, joe@perches.com
Cc: Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150407170539.OVAiHXYjTYdddOLxVcTOlae-FaglVmThB-NEjCl0uA0@z>

Hi Andreas,

On 04/07/2015 12:51 PM, Andreas Färber wrote:
> Am 07.04.2015 um 18:30 schrieb Maxime Coquelin:
>> This drivers adds support to the STM32 USART controller, which is a
>> standard serial driver.
>>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  drivers/tty/serial/Kconfig       |  17 +
>>  drivers/tty/serial/Makefile      |   1 +
>>  drivers/tty/serial/stm32-usart.c | 735 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/serial_core.h |   3 +
>>  4 files changed, 756 insertions(+)
>>  create mode 100644 drivers/tty/serial/stm32-usart.c
> [...]
>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
>> new file mode 100644
>> index 0000000..4adc430
>> --- /dev/null
>> +++ b/drivers/tty/serial/stm32-usart.c
> [...]
>> +#define DRIVER_NAME "stm32-usart"
>> +#define STM32_SERIAL_NAME "ttyS"
> 
> I'm surprised no one has complained about ttyS yet. Doesn't that need to
> be unique, such as ttySTM (efm32 uses ttyefm), to avoid clashes between
> serial drivers? ttyS was exclusive to the 8250 driver, I thought.

As long as this platform doesn't support 8250 h/w, I don't care; and
by the time this platform is ready for multiconfig, I'll have ttyS
coexistence fixed.

Regards,
Peter Hurley
