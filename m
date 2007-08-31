Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48617 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753980AbXHaWi4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 31 Aug 2007 18:38:56 -0400
Date: Fri, 31 Aug 2007 23:47:21 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Heads Up: Next Batch Of Serial/TTY Changes
Message-ID: <20070831234721.5275f5d0@the-village.bc.nu>
In-Reply-To: <20070831.152315.39158142.davem@davemloft.net>
References: <20070831221105.2fce9023@the-village.bc.nu>
	<20070831.144115.48807246.davem@davemloft.net>
	<20070831231613.6b0fcdfd@the-village.bc.nu>
	<20070831.152315.39158142.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-serial@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Who knows what other gremlins like this now live in the tree :-)
> 
> There was a similar spot a few lines down, both fixed
> as follows:

Thanks I'll take a harder look over those. My test suite didn't check
them just the main termios ioctls didn't scribble.

> And here is the sparc patch, could you please add it to
> your serial queue?  Thanks Alan.
> 
> [SPARC]: Add support for arbitrary serial speeds.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>cc[VEOF]); \


Thanks

Alan
