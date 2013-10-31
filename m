From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: [PATCH 08/11] ARM: u300: use the common machine reset handling
Date: Thu, 31 Oct 2013 16:19:50 +0100
Message-ID: <20131031151950.GA16491@glitch>
References: <20131031062708.520968323@linux.com>
 <20131031063000.361406973@linux.com>
 <CACRpkdbzmqGpQKf5Mz7tKfRAuTNWV+WYSuerNFQOAsgdUOaoTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:55292 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab3JaPT7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 11:19:59 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdbzmqGpQKf5Mz7tKfRAuTNWV+WYSuerNFQOAsgdUOaoTg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Domenico Andreoli <domenico.andreoli@linux.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 31, 2013 at 07:40:25AM -0700, Linus Walleij wrote:
> On Wed, Oct 30, 2013 at 11:27 PM, Domenico Andreoli
> <domenico.andreoli@linux.com> wrote:
> 
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> >
> > Proof of concept: u300 as provider of reset hooks.
> 
> Do you have a u300 to test this on or are you just guessing?

I don't have any u300, I picked it randomly. It's just to show some usage
and possibly discuss it. There are quite a lot of these hooks all around.

> Anyway, concept looks correct, so Acked-by given that the
> overall idea is accepted.

uhm.. don't see any general acceptance right now. maybe later..

thanks,
Domenico
