Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw1.cosmosbay.com ([86.65.150.130]:38838 "EHLO
	gw1.cosmosbay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161353AbXCIARX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2007 19:17:23 -0500
Message-ID: <45F0A3FA.5030308@cosmosbay.com>
Date: Fri, 09 Mar 2007 01:02:02 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
Subject: Re: [PATCH] NET : Introduce SIOCGSTAMPNS ioctl to get timestamps
 with nanosec resolution
References: <200703081919.47732.dada1@cosmosbay.com> <25904.1173388268@redhat.com>
In-Reply-To: <25904.1173388268@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, Patrick McHardy <kaber@trash.net>, David Miller <davem@davemloft.net>
List-ID: <linux-arch.vger.kernel.org>

David Howells a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
> 
>> +#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
>> +#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
> 
> Is it worth munging these together into an asm-generic header for those arches
> that have the same sets of ioctl numbers?
> 

Yes probably... But it can be done in a distinct patch ?
