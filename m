Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53205 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab3DPJju (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 05:39:50 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq17so1655918wib.5
        for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2013 02:39:49 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/4] gpio: rename CONFIG_GPIOLIB to CONFIG_GPIO
In-Reply-To: <1365445950-5736-4-git-send-email-gnurou@gmail.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com> <1365445950-5736-4-git-send-email-gnurou@gmail.com>
Date: Tue, 16 Apr 2013 10:39:46 +0100
Message-ID: <20130416093946.0DB503E14C0@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Message-ID: <20130416093946.Rf8eaqj1D6ipKowZEdoPw803KYu86buOrxEkRJvGqJ4@z>

On Mon,  8 Apr 2013 11:32:29 -0700, Alexandre Courbot <gnurou@gmail.com> wrote:
> From: Alexandre Courbot <acourbot@nvidia.com>
> 
> The removal of CONFIG_GENERIC_GPIO turned gpiolib into the only way to
> implement the generic GPIO API, effectively making it the "GPIO
> framework".
> 
> This patch tries to reflect this reality by changing occurences of
> GPIOLIB into the simpler GPIO in various places (notable configuration
> options) and updating the documentation.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

This just ends up being painful and extra churn. I don't think it is
worth it to change the config symbol name.

g.

