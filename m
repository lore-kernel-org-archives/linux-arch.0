Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269404AbUINO5H@vger.kernel.org>
Received: from [213.146.154.40] ([213.146.154.40]:44470 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S269379AbUINO4L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Sep 2004 10:56:11 -0400
Subject: Re: Add skeleton "generic IO mapping" infrastructure.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <41470074.9010900@pobox.com>
References: <200409132206.i8DM6dSC030620@hera.kernel.org>
	 <1095152147.9144.254.camel@imladris.demon.co.uk>
	 <41470074.9010900@pobox.com>
Content-Type: text/plain
Message-Id: <1095173761.24547.203.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Tue, 14 Sep 2004 15:56:01 +0100
Content-Transfer-Encoding: 7bit
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

< moved to linux-arch >

On Tue, 2004-09-14 at 10:30 -0400, Jeff Garzik wrote:
> > Argh! Please no. You can't infer the IO space from the address. Provide
> > a cookie containing {space, address} instead -- or indeed {bus,
> > address}. Let some architectures optimise that by ignoring the bus and
> > working it out from the address if you must, but don't put that in the
> > generic version.
> 
> Override it in your arch if you don't like the generic version ;-)

No, seriously, let's not introduce a new API which is _already_
insufficient to disambiguate between the various things the caller might
want. A 'void *' is not sufficient to give both bus and address. Use a
tuple of { bus, addr } or { dev, addr } instead.

For platforms where it really doesn't matter you can optimise it out by
not looking at the device argument.

-- 
dwmw2
