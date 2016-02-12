From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] earlycon: rework common framework for earlycon declarations
Date: Fri, 12 Feb 2016 11:05:55 +0100
Message-ID: <4230998.Zt9XrE8YSr@wuerfel>
References: <1455269296-5009-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:53472 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbcBLKGs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Feb 2016 05:06:48 -0500
In-Reply-To: <1455269296-5009-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Greg KH <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>

On Friday 12 February 2016 18:28:16 Masahiro Yamada wrote:
> Commit 71f50c6d9a22 ("of: drop symbols declared by _OF_DECLARE() from
> modules") fixed the link error introduced by commit b8d20e06eaad
> ("serial: 8250_uniphier: add earlycon support").
> 
> After commit 2eaa790989e0 ("earlycon: Use common framework for
> earlycon declarations") was applied, the link error came back
> because the commit reworked OF_EARLYCON_DECLARE() to not use
> _OF_DECLARE().
> 
> This commit reworks OF_EARLYCON_DECLARE() again based on
> _OF_DECLARE().  My motivations are:
> 
>  - Fix the link error in a generic way (without patching
>    drivers/tty/serial/8250/8250_uniphier.c)
> 
>  - Delete struct earlycon_id.  This struct is re-inventing the wheel;
>    the fields "name", "compatible", "setup" can be implemented in
>    struct of_device_id as other framework do.
> 
> The difference between OF_EARLYCON_DECLARE() and other users of
> _OF_DECLARE is that OF_EARLYCON_DECLARE() needs to fill the "name"
> field of struct of_device_id.  To make it easier, a new macro
> _OF_DECLARE_WITH_NAME() has been added.  It fills the name field
> with the given argument.  On the other hand, _OF_DECLARE() sets the
> "name" field to a null string; this is the same behavior as before.
> 
> Fixes: 2eaa790989e0 ("earlycon: Use common framework for earlycon declarations")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> I confirmed this patch can apply onto "next-20160212" tag of linux-next.
> 
> In order to apply it onto the "tty-next" branch of TTY subsytem,
> Grag will have to pull v4.5-rc3 in.

I think this is the right approach, and I can include it in my 8250
series when I resend it, and rebase the other patches on top of it
to simplify them.

Peter, since you did the change "earlycon: Use common framework for
earlycon declarations", are you ok with the new version?

	Arnd
