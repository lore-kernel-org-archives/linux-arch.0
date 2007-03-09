Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55462
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1161355AbXCIAS6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Mar 2007 19:18:58 -0500
Date: Thu, 08 Mar 2007 16:18:58 -0800 (PST)
Message-Id: <20070308.161858.98552938.davem@davemloft.net>
Subject: Re: [PATCH] NET : Introduce SIOCGSTAMPNS ioctl to get timestamps
 with nanosec resolution
From: David Miller <davem@davemloft.net>
In-Reply-To: <45F0A3FA.5030308@cosmosbay.com>
References: <200703081919.47732.dada1@cosmosbay.com>
	<25904.1173388268@redhat.com>
	<45F0A3FA.5030308@cosmosbay.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
To: dada1@cosmosbay.com
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, kaber@trash.net
List-ID: <linux-arch.vger.kernel.org>

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Fri, 09 Mar 2007 01:02:02 +0100

> David Howells a écrit :
> > Eric Dumazet <dada1@cosmosbay.com> wrote:
> > 
> >> +#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
> >> +#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
> > 
> > Is it worth munging these together into an asm-generic header for those arches
> > that have the same sets of ioctl numbers?
> > 
> 
> Yes probably... But it can be done in a distinct patch ?

I definitely think so :)
