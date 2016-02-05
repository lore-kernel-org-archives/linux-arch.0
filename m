From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/2] GPIO: Clean up asm/gpio.h
Date: Fri, 5 Feb 2016 14:43:20 +0100
Message-ID: <CACRpkdY-8+vhsCsQGL7YUOgoXA=+_6c=69ZB=aowQgNun8bXqw@mail.gmail.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 2, 2016 at 8:53 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> Many arches supply an asm/gpio.h that contains only this:
>
>   #warning Include linux/gpio.h instead of asm/gpio.h
>   #include <linux/gpio.h>
>
> These two patches change all the places that include asm/gpio.h
> so they include linux/gpio.h instead, and then remove the asm/gpio.h
> files.
>
> There are several arches that supply asm/gpio.h with useful
> arch-specific content; I didn't touch those.
>
> I assume Mark was heading this direction with 7563bbf89d06
> ("gpiolib/arches: Centralise bolierplate asm/gpio.h").

Sweet, if I can get the arch maintainers ACK on this I can
merge it into the GPIO tree, Arnd?

Yours,
Linus Walleij
