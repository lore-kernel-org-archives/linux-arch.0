From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 1/1] gpio: lib: Add gpio_is_enabled() to get pin mode
Date: Tue, 15 Nov 2016 17:06:48 +0530
Message-ID: <582AF350.1000007@nvidia.com>
References: <1478089037-26441-1-git-send-email-ldewangan@nvidia.com> <CACRpkdYjWiy-PyBhN8gRa5TM5ARXrCZ-KqBXYm-bVeXFY11MQw@mail.gmail.com> <5825B6D4.1000600@nvidia.com> <CACRpkdacDcy_Y_5g8739DF+f3fRzzMQ_bkM1TQ+uTtPq1=VmFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdacDcy_Y_5g8739DF+f3fRzzMQ_bkM1TQ+uTtPq1=VmFg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


On Tuesday 15 November 2016 02:33 PM, Linus Walleij wrote:
> On Fri, Nov 11, 2016 at 1:17 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
>>> Yeah but since pinctrl and pinmux has its own debugfs files why is this
>>> necessary? I understand it is convenient but only for debugging
>>> right? They the inconvenience of using pinctrls debugfs files should
>>> be bearable.
>> Yes, it is debugging and capturing all the info at single place. Currently,
>> gpio debugFs shows the gpio related stuff and the pinctrl on pinconfig but
>> there is not any dump which shows the complete pin mapping.
>> The effort is to compile all the data in single place with proper message to
>> avoid any manual work for decoding multiple outputs.
> I don't know if this is a good idea. I don't want to clutter the
> gpiolib ABI for no good reason.
>
> For certain this should only be available for drivers using pin
> control as a back-end for their GPIOs.
>
> For that purpose we have (in <linux/pinctrl/consumer.h>:
>
> /* External interface to pin control */
> extern int pinctrl_request_gpio(unsigned gpio);
> extern void pinctrl_free_gpio(unsigned gpio);
> extern int pinctrl_gpio_direction_input(unsigned gpio);
> extern int pinctrl_gpio_direction_output(unsigned gpio);
>
> It would be more natural to add a function pinctrl_is_gpio(unsigned gpio)
> to call back to the pin controller, then that can be called from
> the generic or driver-specific debug print callback.

We have two type of IPs, GPIO mode is configured in the register which 
is part of GPIO controller and in other IP, it is configured in register 
which is in pincontroller registers.

Your suggested API pinctrl_is_gpio() will definitely help on second case 
and I will work on this once we will have the new IP driver in mainline. 
This will be in coming T186 patches.


For T210 SoC, the configuration is done in gpio controller and we need 
to have debug utility outside of driver and hence the requirements was.



