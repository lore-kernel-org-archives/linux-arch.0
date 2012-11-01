From: David Miller <davem@davemloft.net>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
Date: Thu, 01 Nov 2012 11:06:58 -0400 (EDT)
Message-ID: <20121101.110658.149879582446959580.davem@davemloft.net>
References: <20121101130420.GB20982@kroah.com>
	<20121101132342.GE12489@arwen.pp.htv.fi>
	<87k3u5h296.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60098 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761927Ab2KAPHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 11:07:10 -0400
In-Reply-To: <87k3u5h296.fsf@nemi.mork.no>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bjorn@mork.no
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, fengguang.wu@intel.com, kuninori.morimoto.gx@renesas.com, linux-usb@vger.kernel.org

=46rom: Bj=F8rn Mork <bjorn@mork.no>
Date: Thu, 01 Nov 2012 14:38:29 +0100

> Felipe Balbi <balbi@ti.com> writes:
>=20
>> btw, only alpha and x86 seem to be providing all of those, but if yo=
u
>> look into our documentation, it's said that drivers are supposed to =
use
>> write/read{b,w,l,q} for all memory-mapped io. I'd expect all platfor=
ms
>> to provide those even if just to allow compilation of drivers.
>=20
> Only if HAS_IOMEM is true, I believe.

This is correct.
