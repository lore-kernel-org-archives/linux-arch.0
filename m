Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46823 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934004AbeGCRot (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2018 13:44:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com> <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Jul 2018 14:44:47 -0300
Message-ID: <CAOMZO5DpOG5G750gYXdVJWwwtOi4BF0wSBxfuVPdFJqnJonD7Q@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Dan Douglass <dan.douglass@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20180703174447.ufadYrgYf9a48a2bkFXULQmjoUEYVQYfUEZp9BB78ZU@z>

Hi Andy,

On Tue, Jul 3, 2018 at 2:36 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Oops, first of all the header should be hi-lo instead of lo-hi.
> Does it fix it?

I tried as you suggested:

--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -10,7 +10,7 @@

 #include <linux/types.h>
 #include <linux/bitops.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-hi-lo.h>

 /*
  * Architecture-specific register access method

but it still crashes the kernel.

Thanks
