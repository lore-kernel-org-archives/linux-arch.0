Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933338AbXCHVM1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Mar 2007 16:12:27 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200703081919.47732.dada1@cosmosbay.com> 
References: <200703081919.47732.dada1@cosmosbay.com> 
Subject: Re: [PATCH] NET : Introduce SIOCGSTAMPNS ioctl to get timestamps with nanosec resolution 
Date: Thu, 08 Mar 2007 21:11:08 +0000
Message-ID: <25904.1173388268@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-arch@vger.kernel.org, Patrick McHardy <kaber@trash.net>, David Miller <davem@davemloft.net>
List-ID: <linux-arch.vger.kernel.org>

Eric Dumazet <dada1@cosmosbay.com> wrote:

> +#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
> +#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */

Is it worth munging these together into an asm-generic header for those arches
that have the same sets of ioctl numbers?

David
