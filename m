Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f194.google.com ([209.85.212.194]:56035 "EHLO
	mail-wi0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbbBMQA0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Feb 2015 11:00:26 -0500
MIME-Version: 1.0
In-Reply-To: <1423828144.4182.18.camel@pengutronix.de>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1423763164-5606-5-git-send-email-mcoquelin.stm32@gmail.com>
	<1423828144.4182.18.camel@pengutronix.de>
Date: Fri, 13 Feb 2015 17:00:24 +0100
Message-ID: <CALszF6BVOv40fBTMU8tsnrFXuFPMFHpToZb7O8mRXQQpmsW4eg@mail.gmail.com>
Subject: Re: [PATCH 04/14] reset: Add reset_controller_of_init() function
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150213160024.2DW_DIVr_1yUAHwJF0ksp6ro8AiYpKsyg4R7i5HZ0_8@z>

Hi Philipp,

2015-02-13 12:49 GMT+01:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Hi Maxime,
>
> Am Donnerstag, den 12.02.2015, 18:45 +0100 schrieb Maxime Coquelin:
>> Some platforms need to initialize the reset controller before the timers.
>>
>> This patch introduces a reset_controller_of_init() function that can be
>> called before the timers intialization.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  drivers/reset/core.c              | 20 ++++++++++++++++++++
>>  include/asm-generic/vmlinux.lds.h |  4 +++-
>>  include/linux/reset-controller.h  |  6 ++++++
>>  3 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>> index 7955e00..18ee579 100644
>> --- a/drivers/reset/core.c
>> +++ b/drivers/reset/core.c
>> @@ -86,6 +86,26 @@ void reset_controller_unregister(struct reset_controller_dev *rcdev)
>>  }
>>  EXPORT_SYMBOL_GPL(reset_controller_unregister);
>>
>> +extern struct of_device_id __reset_ctrl_of_table[];
>> +
>> +static const struct of_device_id __reset_ctrl_of_table_sentinel
>> +     __used __section(__reset_ctrl_of_table_end);
>> +
>> +void __init reset_controller_of_init(void)
>
> The patch looks fine to me, but this function is missing a kerneldoc
> comment.

Right! It will be fixed in the v2.

Thanks,
Maxime
