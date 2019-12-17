Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:48123 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfLQOGy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 09:06:54 -0500
Date: Tue, 17 Dec 2019 15:06:46 +0100
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] RFC: platform driver registering via initcall tables
Message-ID: <20191217140646.GC3489463@kroah.com>
References: <20191217102219.29223-1-info@metux.net>
 <20191217103152.GB2914497@kroah.com>
 <6422bc88-6d0a-7b51-aaa7-640c6961b177@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6422bc88-6d0a-7b51-aaa7-640c6961b177@metux.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, dmitry.torokhov@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, arnd@arndb.de, masahiroy@kernel.org, michal.lkml@markovi.net, kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <20191217140646.AxhyiJ_VCZlYYbrSPhVIV6cMNrLFC167kroMXCD6Ohg@z>

On Tue, Dec 17, 2019 at 02:44:39PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 17.12.19 11:31, Greg KH wrote:
> 
> Hi,
> 
> > No, what is so "special" about platform drivers that they require this?
> 
> Nothing, of course ;-)
> 
> It's the the starting point for this PoC. The idea actually is doing
> this for all other driver types, too (eg. spi, pci, usb, ...). But
> they'll need their own tables, as different *_register() functions have
> to be called - just haven't implemented that yet.

That's not needed, and you are going to break the implicit ordering we
already have with link order.  You are going to have to figure out what
bus type the driver is, to determine what segment it was in, to figure
out what was loaded before what.

Not good.

> > If anything, we should be moving _AWAY_ from platform drivers and use
> > real bus drivers instead.
> 
> That would be nice, but, unfortunately, we have lots of devices which
> aren't attached to any (probing-capable) bus. That's why we have things
> like oftree, etc.
> 
> > Please no, I don't see why this is even needed.
> 
> The idea is getting rid of all the init code, which all just does the
> same, just calls some *_register() function.

There's no need to get rid of it, what are you trying to save here?  How
can you be sure init order is still the same?

thanks,

greg k-h
