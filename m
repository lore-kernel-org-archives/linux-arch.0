Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:42809 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaAWIMn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2014 03:12:43 -0500
Received: by mail-oa0-f42.google.com with SMTP id i7so1782904oag.29
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2014 00:12:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1390339396-3479-60-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
	<1390339396-3479-60-git-send-email-paul.gortmaker@windriver.com>
Date: Thu, 23 Jan 2014 09:12:43 +0100
Message-ID: <CACRpkdYk6cOO-JZbe887ihJaWE5JMjuXm3EVcZmE1jCeL2BODQ@mail.gmail.com>
Subject: Re: [PATCH 59/73] drivers/gpio: delete non-required instances of
 include <linux/init.h>
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Message-ID: <20140123081243.jYct-efL1atrd8ElRgyERKs_NMEsiPS5eFvPtYLaQ4U@z>

On Tue, Jan 21, 2014 at 10:23 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Patch applied for v3.15.

Yours,
Linus Walleij
