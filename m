Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:35008 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761205Ab2KANiu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 09:38:50 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error: implicit declaration of function 'iowrite32'
References: <50924f0a.QuF7xjrp4IUSKMwd%fengguang.wu@intel.com>
	<20121101103339.GD410@arwen.pp.htv.fi>
	<20121101105034.GE410@arwen.pp.htv.fi>
	<20121101130420.GB20982@kroah.com>
	<20121101132342.GE12489@arwen.pp.htv.fi>
Date: Thu, 01 Nov 2012 14:38:29 +0100
In-Reply-To: <20121101132342.GE12489@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Thu, 1 Nov 2012 15:23:42 +0200")
Message-ID: <87k3u5h296.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: balbi@ti.com
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-usb@vger.kernel.org
Message-ID: <20121101133829.SUocXCxBP-Ap2Vy7bkGm5EmFOJkqJOkHQeuQ_atAv4Q@z>

Felipe Balbi <balbi@ti.com> writes:

> btw, only alpha and x86 seem to be providing all of those, but if you
> look into our documentation, it's said that drivers are supposed to use
> write/read{b,w,l,q} for all memory-mapped io. I'd expect all platforms
> to provide those even if just to allow compilation of drivers.

Only if HAS_IOMEM is true, I believe.


Bjørn
