From: David Miller <davem@davemloft.net>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
Date: Thu, 01 Nov 2012 11:07:29 -0400 (EDT)
Message-ID: <20121101.110729.2080098706669174559.davem@davemloft.net>
References: <20121101130420.GB20982@kroah.com>
	<20121101132342.GE12489@arwen.pp.htv.fi>
	<CAMo8BfLoU0GLpncX7YXy_VvveFnR6f6guPJTLNdtt3SWDK1fcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60106 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932893Ab2KAPHr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 11:07:47 -0400
In-Reply-To: <CAMo8BfLoU0GLpncX7YXy_VvveFnR6f6guPJTLNdtt3SWDK1fcg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: jcmvbkbc@gmail.com
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, fengguang.wu@intel.com, kuninori.morimoto.gx@renesas.com, linux-usb@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 1 Nov 2012 16:47:14 +0300

> Strange, AFAICS architectures that use asm-generic/io.h (blackfin, openrisc,
> score, unicore32 and xtensa) also provide those functions.

They define HAVE_IOMEM, s390 does not, therefore you must protect
the driver Kconfig with HAVE_IOMEM.
