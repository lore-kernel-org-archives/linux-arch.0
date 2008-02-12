Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-1.cisco.com ([171.71.176.70]:43620 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759197AbYBLRv5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2008 12:51:57 -0500
Subject: Re: multiple drivers, single device
References: <20080212120208.f7168a91.sfr@canb.auug.org.au>
	<20080212042133.GA4625@kroah.com> <47B1C829.8020800@garzik.org>
	<20080212164232.GA326@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 12 Feb 2008 09:42:20 -0800
In-Reply-To: <20080212164232.GA326@kroah.com> (Greg KH's message of "Tue, 12 Feb 2008 08:42:32 -0800")
Message-ID: <adak5lavzpf.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jeff@garzik.org>, Stephen Rothwell <sfr@canb.auug.org.au>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus <torvalds@linux-foundation.org>

 > The work I'm doing here is for stupid PCI firmware engineers, who have
 > created devices that are different things, all bound up under the same
 > PCI device.  I'm thinking of watchdog timers and random number
 > generator and i2c controller on the same PCI device, or even the more
 > basic, frame buffer and DRM access to the same PCI video device.
 > 
 > The OLPC is a good example of hardware that needs this kind of
 > functionality.

Sounds interesting.  I've been meaning to work on this too for quite a
while, but I'm glad to see you beat me to it.

An example of an in-tree use case for this would be the mlx4 drivers--
you can look at drivers/net/mlx4/intf.c to see the simple stupid
solution I came up with to allow an IB and a NIC (not yet upstream)
driver to share the same PCI device.  A good test for your stuff would
be if it simplifies the code from the ad hoc solution I came up with.

 - R.
