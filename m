From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 08/11] ARM: u300: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:40:25 -0700
Message-ID: <CACRpkdbzmqGpQKf5Mz7tKfRAuTNWV+WYSuerNFQOAsgdUOaoTg@mail.gmail.com>
References: <20131031062708.520968323@linux.com>
	<20131031063000.361406973@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:60675 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab3JaOkZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 10:40:25 -0400
Received: by mail-oa0-f42.google.com with SMTP id k14so3189557oag.29
        for <linux-arch@vger.kernel.org>; Thu, 31 Oct 2013 07:40:25 -0700 (PDT)
In-Reply-To: <20131031063000.361406973@linux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>

On Wed, Oct 30, 2013 at 11:27 PM, Domenico Andreoli
<domenico.andreoli@linux.com> wrote:

> From: Domenico Andreoli <domenico.andreoli@linux.com>
>
> Proof of concept: u300 as provider of reset hooks.

Do you have a u300 to test this on or are you just guessing?

Anyway, concept looks correct, so Acked-by given that the
overall idea is accepted.

Yours,
Linus Walleij
