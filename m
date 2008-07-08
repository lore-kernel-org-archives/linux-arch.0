From: "John Williams" <john.williams@petalogix.com>
Subject: Re: [PATCH 19/58] microblaze_v5: early_printk support
Date: Wed, 9 Jul 2008 09:47:29 +1000
Message-ID: <1d3f23370807081647y446534dp6db16f560e4e0a2d@mail.gmail.com>
References: <80a2e46f2fb93812ab12bf79c703e8e2d6b0faa0.1215517976.git.monstr@monstr.eu>
	 <2aa1ac7891af57959237aae3addf4bbe607f55d7.1215517976.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:32212 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbYGHXrb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jul 2008 19:47:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1091993fgg.17
        for <linux-arch@vger.kernel.org>; Tue, 08 Jul 2008 16:47:30 -0700 (PDT)
In-Reply-To: <2aa1ac7891af57959237aae3addf4bbe607f55d7.1215517976.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: linux-kernel@vger.kernel.org, monstr@seznam.cz, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, lethal@linux-sh.org, florian@openwrt.org

> +++ b/arch/microblaze/kernel/early_printk.c
> @@ -0,0 +1,130 @@

> +#ifdef CONFIG_EARLY_PRINTK
> +#define BASE_ADDR ((unsigned char *)CONFIG_EARLY_PRINTK_UARTLITE_ADDRESS)

This is a problem - default value of EARLY_PRINTK_UARTLITE_ADDRESS is
0x0, so by default the kernel will try to access a uartlite at 0x0
which is the reset vector!  I know there is the test in the actual
output routine but it's not good to rely on that in the default case.

Can we either

#if CONFIG_EARLY_PRINTK_UARTLITE_ADDRESS==0
#warning EARLY_PRINTK address not set, disabling
...
#else
..
#endif

or query the OF subsystem (is it up yet?), and default to using the
first uartlite in the system for early printk?

John
