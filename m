Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269029AbUINPJd@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:981 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269021AbUINPIP
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Sep 2004 11:08:15 -0400
Message-ID: <41470952.5080108@pobox.com>
Date: Tue, 14 Sep 2004 11:08:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Subject: Re: Add skeleton "generic IO mapping" infrastructure.
References: <200409132206.i8DM6dSC030620@hera.kernel.org>	 <1095152147.9144.254.camel@imladris.demon.co.uk>	 <41470074.9010900@pobox.com> <1095173761.24547.203.camel@hades.cambridge.redhat.com>
In-Reply-To: <1095173761.24547.203.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Woodhouse wrote:
> No, seriously, let's not introduce a new API which is _already_
> insufficient to disambiguate between the various things the caller might
> want. A 'void *' is not sufficient to give both bus and address. Use a
> tuple of { bus, addr } or { dev, addr } instead.

The existing setup is perfectly sufficient.

You pass (dev,addr) to an arch-specific function which creates the 
cookie in an arch-specific manner.

	Jeff
