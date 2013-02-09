Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55936 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab3BINYk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Feb 2013 08:24:40 -0500
Received: by mail-we0-f174.google.com with SMTP id r6so3738795wey.5
        for <linux-arch@vger.kernel.org>; Sat, 09 Feb 2013 05:24:39 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/9] gpiolib: use descriptors internally
In-Reply-To: <1359822572-26009-8-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com> <1359822572-26009-8-git-send-email-acourbot@nvidia.com>
Date: Sat, 09 Feb 2013 13:24:35 +0000
Message-ID: <20130209132435.169133E30EC@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
Message-ID: <20130209132435.Mq986fD_6lzGd_XV6uVSRKJlr3GqOEgr8ScbZ7M9FCE@z>

On Sun,  3 Feb 2013 01:29:29 +0900, Alexandre Courbot <acourbot@nvidia.com> wrote:
> Make sure gpiolib works internally with descriptors and (chip, offset)
> pairs instead of using the global integer namespace. This prepares the
> ground for the removal of the global gpio_desc[] array and the
> introduction of the descriptor-based GPIO API.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Despite Linus' comments, I've gone ahead and applied this. I think it is
a worthwhile change on its own and it feeds into the future work than
needs to be done. Any of the stuff he brought up can be addressed in
follow-on patches.

g.

