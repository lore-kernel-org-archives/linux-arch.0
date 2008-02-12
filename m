Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48660 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762211AbYBLSby (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Feb 2008 13:31:54 -0500
Message-ID: <47B1DDD3.2000402@garzik.org>
Date: Tue, 12 Feb 2008 12:56:35 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Subject: Re: multiple drivers, single device (was Re: Announce: Linux-next
 (Or Andrew's dream  :-)))
References: <20080212120208.f7168a91.sfr@canb.auug.org.au> <20080212042133.GA4625@kroah.com> <47B1C829.8020800@garzik.org> <20080212164232.GA326@kroah.com>
In-Reply-To: <20080212164232.GA326@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus <torvalds@linux-foundation.org>

Greg KH wrote:
> The work I'm doing here is for stupid PCI firmware engineers, who have
> created devices that are different things, all bound up under the same
> PCI device.  I'm thinking of watchdog timers and random number
> generator and i2c controller on the same PCI device, or even the more
> basic, frame buffer and DRM access to the same PCI video device.

Yes, that has a known solution:  have your driver register i2c, rng, 
watchdog, etc. functions.

Works just fine inside today's infrastructure, no changes needed.

	Jeff


