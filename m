From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] RFC: platform driver registering via initcall tables
Date: Tue, 17 Dec 2019 14:44:39 +0100
Message-ID: <6422bc88-6d0a-7b51-aaa7-640c6961b177@metux.net>
References: <20191217102219.29223-1-info@metux.net>
 <20191217103152.GB2914497@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191217103152.GB2914497@kroah.com>
Content-Language: tl
Sender: netdev-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, dmitry.torokhov@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, arnd@arndb.de, masahiroy@kernel.org, michal.lkml@markovi.net, kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 17.12.19 11:31, Greg KH wrote:

Hi,

> No, what is so "special" about platform drivers that they require this?

Nothing, of course ;-)

It's the the starting point for this PoC. The idea actually is doing
this for all other driver types, too (eg. spi, pci, usb, ...). But
they'll need their own tables, as different *_register() functions have
to be called - just haven't implemented that yet.

> If anything, we should be moving _AWAY_ from platform drivers and use
> real bus drivers instead.

That would be nice, but, unfortunately, we have lots of devices which
aren't attached to any (probing-capable) bus. That's why we have things
like oftree, etc.

> Please no, I don't see why this is even needed.

The idea is getting rid of all the init code, which all just does the
same, just calls some *_register() function.


--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
