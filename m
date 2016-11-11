From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 1/1] gpio: lib: Add gpio_is_enabled() to get pin mode
Date: Fri, 11 Nov 2016 17:47:24 +0530
Message-ID: <5825B6D4.1000600@nvidia.com>
References: <1478089037-26441-1-git-send-email-ldewangan@nvidia.com> <CACRpkdYjWiy-PyBhN8gRa5TM5ARXrCZ-KqBXYm-bVeXFY11MQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYjWiy-PyBhN8gRa5TM5ARXrCZ-KqBXYm-bVeXFY11MQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


On Saturday 05 November 2016 03:50 AM, Linus Walleij wrote:
> On Wed, Nov 2, 2016 at 1:17 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
>> Many of devices/SoCs supports the GPIO and special IO function
>> from their pins. On such cases, there is always configuration
>> bits to select the mode of pin as GPIO or as the special IO mode.
>> The functional modes are selected by pinmux option.
>>
>> When device booted and reach to kernel, it is not possible to get
>> the current configuration of pin whether it is in GPIO mode or
>> in special IO mode without configurations.
>>
>> Add APIs to return the current mode of pins without requesting it
>> as GPIO to find out the current mode.
>> This helps on dumping the pin configuration from debug/test utility
>> to get the current mode GPIO or functional mode.
>>
>> The typical utility looks as:
>> pin_dump(pin)
>> {
>>          if(gpio_is_enabled(pin)) {
>>                  dump direction using get_direction()
>>          } else {
>>                  dump pinmux option and its configurations.
>>          }
>> }
> Yeah but since pinctrl and pinmux has its own debugfs files why is this
> necessary? I understand it is convenient but only for debugging
> right? They the inconvenience of using pinctrls debugfs files should
> be bearable.

Yes, it is debugging and capturing all the info at single place. 
Currently, gpio debugFs shows the gpio related stuff and the pinctrl on 
pinconfig but there is not any dump which shows the complete pin mapping.
The effort is to compile all the data in single place with proper 
message to avoid any manual work for decoding multiple outputs.


>
> Also it is possible for any GPIO chip to implement its own
> debug print if they like, check what we do in
> ->dbg_show in drivers/pinctrl/nomadik/pinctrl-nomadik.c
> for example.
>
> If the use is for debug prints, keep it driver-local.
>
> (...)

This callback can print the stuff for GPIO related stuff as there is not 
much info about the pinmux related configuration to gpio driver. For 
GPIO or functional mode, it can only display gpio or functional mode.

Is there something we can link from gpio driver to pinctrl driver like 
pinctrl_debug_show()?
Like in gpio_request(), we say that pinctrl_request(), similary on the 
GPIO dbg_show(), we can say pinctrl_dbg_show() and get all the info for 
prints.
This will also serve the purpose.
