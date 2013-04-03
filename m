From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] gpio: remove GENERIC_GPIO completely
Date: Wed, 3 Apr 2013 15:28:03 +0200
Message-ID: <CACRpkdak79-KuSXdRb7B83Xe+6-f-gNK12Q+EVbXNPSwJLqgrw@mail.gmail.com>
References: <1364562678-8945-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:55051 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760704Ab3DCN2F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2013 09:28:05 -0400
Received: by mail-ia0-f169.google.com with SMTP id j5so1271139iaf.28
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2013 06:28:04 -0700 (PDT)
In-Reply-To: <1364562678-8945-1-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Romain Naour <romain.naour@openwide.fr>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>

On Fri, Mar 29, 2013 at 2:11 PM, Alexandre Courbot <gnurou@gmail.com> wrote:

> Since I have received no death threat from architecture maintainers I'd like to
> proceed with the remainder of this work so that it doesn't go half-baked into
> 3.10. These three patches finish the removal of the GENERIC_GPIO config option
> which has been made equivalent to GPIOLIB in the previous series. It does so by
> first changing all references to GENERIC_GPIO into GPIOLIB in driver code and
> configuration files, and then removing the unused option from the Kconfig files
> where it is declared.
>
> The last patch in the series confirms gpiolib in its new role as GPIO framework
> by renaming CONFIG_GPIOLIB into CONFIG_GPIO, following the model used by other
> frameworks. This name changing might rise concern but it seems more logical to
> me and the historical gpiolib name is still mentioned in the documentation to
> relieve the confusion.
>
> If I can get a few acks on these (or at least the first two ones) I'd like to
> include them into my next branch as soon as possible so points of breakage can
> be fixed. There are indeed a few new users of GENERIC_GPIO (CC Romain, I sent a
> warning but saw no action so far) in the next tree and compilation will break
> for them.
>
> Another issue, I could not update the Chinese documentation in a satisfying
> manner due to my absence of Chinese skills. Hope that will be forgiven.
>
> Alexandre Courbot (3):
>   Convert selectors of GENERIC_GPIO to GPIOLIB
>   Remove GENERIC_GPIO config option
>   Rename CONFIG_GPIOLIB to CONFIG_GPIO

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
