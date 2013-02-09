Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:45422 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab3BIKKH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Feb 2013 05:10:07 -0500
Received: by mail-wg0-f46.google.com with SMTP id fg15so3497673wgb.1
        for <linux-arch@vger.kernel.org>; Sat, 09 Feb 2013 02:10:06 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/9] gpiolib: link all gpio_chips using a list
In-Reply-To: <CACRpkdZDtJ3AN+Pgxy9nNgVx_YYTC=7AuDC48w7kDbDAeqdufw@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com> <1359822572-26009-3-git-send-email-acourbot@nvidia.com> <CACRpkdZDtJ3AN+Pgxy9nNgVx_YYTC=7AuDC48w7kDbDAeqdufw@mail.gmail.com>
Date: Sat, 09 Feb 2013 09:20:38 +0000
Message-ID: <20130209092039.0C5D23E2548@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
Message-ID: <20130209092038.D-kj_DlNA6FiUOhYBNyivpYj-BLKiskZihzQFoMmobA@z>

On Tue, 5 Feb 2013 18:00:56 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > Add a list member to gpio_chip that allows all chips to be parsed
> > quickly. The current method requires parsing the entire GPIO integer
> > space, which is painfully slow. Using a list makes many chip operations
> > that involve lookup or parsing faster, and also simplifies the code. It
> > is also necessary to eventually get rid of the global gpio_desc[] array.
> >
> > The list of gpio_chips is always ordered by base GPIO number to ensure
> > chips traversal is done in the right order.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> OK!
> 
> > + * Return -EBUSY if the new chip overlaps with some other chip's integer
> > + * space.
> (...)
> > +       /* are we stepping on the chip right before? */
> > +       if (pos != &gpio_chips && pos->prev != &gpio_chips) {
> > +               _chip = list_entry(pos->prev, struct gpio_chip, list);
> > +               if (_chip->base + _chip->ngpio > chip->base) {
> > +                       dev_err(chip->dev,
> > +                              "GPIO integer space overlap, cannot add chip\n");
> > +                       err = -EBUSY;
> > +               }
> > +       }
> 
> This robustness change on its own is a merit for merging the patch.
> And keeping a list of gpiochips available is great for stuff like
> debugfs.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.

