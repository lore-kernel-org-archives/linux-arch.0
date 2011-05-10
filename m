From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: Convert gpio_is_valid to return bool
Date: Wed, 11 May 2011 01:42:22 +0200
Message-ID: <BANLkTikjcJp_PK9pBNyAk-D=MbZ7cr1BPQ@mail.gmail.com>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
	<1304365077.7792.40.camel@Joe-Laptop>
	<BANLkTi=XSevO72NqCYOYuketjE8XjeQU+A@mail.gmail.com>
	<1305067020.19586.130.camel@Joe-Laptop>
	<BANLkTi=zDJLHUa2ogTeEkmdsbkhvGJCsEw@mail.gmail.com>
	<1305069787.19586.141.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37222 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab1EJXmW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2011 19:42:22 -0400
In-Reply-To: <1305069787.19586.141.camel@Joe-Laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

2011/5/11 Joe Perches <joe@perches.com>:

> Make the code a bit more readable.
>
> Instead of casting an int to an unsigned then comparing to
> MAX_NR_GPIOS, add a >= 0 test and let the compiler optimizer
> do the conversion to unsigned.
>
> The generated code should be the same.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Joe!
Linus Walleij
