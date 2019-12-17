Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:38269 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbfLQKb5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 05:31:57 -0500
Date: Tue, 17 Dec 2019 11:31:52 +0100
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] RFC: platform driver registering via initcall tables
Message-ID: <20191217103152.GB2914497@kroah.com>
References: <20191217102219.29223-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217102219.29223-1-info@metux.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, dmitry.torokhov@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, arnd@arndb.de, masahiroy@kernel.org, michal.lkml@markovi.net, kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <20191217103152.F0C6sBRhv0jhK-4S0IgDBPZjhlkH4U6X_iuvWw4EeaU@z>

On Tue, Dec 17, 2019 at 11:22:19AM +0100, Enrico Weigelt, metux IT consult wrote:
> A large portion of platform drivers doesn't need their own init/exit
> functions. At source level, the boilerplate is already replaced by
> module_platform_driver() macro call, which creates this code under
> the hood. But in the binary, the code is still there.
> 
> This patch is an attempt to remove them it, by the same approach
> already used for the init functions: collect pointers to the driver
> structs in special sections, which are then processed by the init
> code which already calls the init function vectors. For each level,
> the structs are processed right after the init funcs, so we guarantee
> the existing order, and explicit inits always come before the automatic
> registering.

No, what is so "special" about platform drivers that they require this?

If anything, we should be moving _AWAY_ from platform drivers and use
real bus drivers instead.

> Downside of apprach: cluttering init code w/ a little bit knowledge
> about driver related stuff (calls to platform_driver_register(), etc).

Exactly, don't.

> For now, only implemented for the built-in case (modules still go the
> old route). The module case is a little bit trickier: either we have to
> extend the module header (and modpost tool) or do some dynamic symbol
> lookup.
> 
> This patch is just a PoC for further discussions, not ready for mainline.
> It also changes a few drivers, just for illustration. In case the general
> approach is accepted, it will be cleaned up and splitted.

Please no, I don't see why this is even needed.

greg k-h
