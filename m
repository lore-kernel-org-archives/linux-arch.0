Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:61719 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab3DPJdc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 05:33:32 -0400
Received: by mail-wg0-f42.google.com with SMTP id m15so954912wgh.5
        for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2013 02:33:31 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/4] gpio: remove GENERIC_GPIO config option
In-Reply-To: <1365445950-5736-3-git-send-email-gnurou@gmail.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com> <1365445950-5736-3-git-send-email-gnurou@gmail.com>
Date: Tue, 16 Apr 2013 10:33:28 +0100
Message-ID: <20130416093328.BBB543E14C0@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Message-ID: <20130416093328.VMb0aWpSQMVTt69f4PXVEXBgsuZEQYgs7SL5cUGlZMY@z>

On Mon,  8 Apr 2013 11:32:28 -0700, Alexandre Courbot <gnurou@gmail.com> wrote:
> From: Alexandre Courbot <acourbot@nvidia.com>
> 
> GENERIC_GPIO has been made equivalent to GPIOLIB in architecture code
> and all driver code has been switch to depend on GPIOLIB. It is thus
> safe to have GENERIC_GPIO removed.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

