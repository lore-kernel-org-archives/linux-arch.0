Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34500 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753024AbeCFKsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Mar 2018 05:48:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180305190824.847-8-logang@deltatee.com>
References: <20180305190824.847-1-logang@deltatee.com> <20180305190824.847-8-logang@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Mar 2018 12:48:29 +0200
Message-ID: <CAHp75Vc41MwtDr24-z3po2nx3Hr7_=tFUD0odcrbnVTP4SnJ1g@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines
 to use the common header
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Jon Mason <jdmason@kudzu.us>
Message-ID: <20180306104829.YG_dEoHKiUKnSNaTuOQWM0k5JMyK5Zkg_h3LSLkX8BI@z>

On Mon, Mar 5, 2018 at 9:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Clean up the ifdefs which conditionally defined the io{read|write}64
> functions in favour of the new common io-64-nonatomic-lo-hi header.

>  #include <linux/kthread.h>
>  #include <linux/interrupt.h>
>  #include <linux/ntb.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>

A nit, can we preserve alphabetical ordering?


-- 
With Best Regards,
Andy Shevchenko
