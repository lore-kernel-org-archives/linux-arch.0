Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:58420 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753745AbXDUAZT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2007 20:25:19 -0400
Date: Fri, 20 Apr 2007 17:25:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: Better local_t implementation needed
In-Reply-To: <20070420.153951.91208263.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0704201723010.13787@schroedinger.engr.sgi.com>
References: <200704201256.13008.ak@suse.de> <200704202325.06301.zippel@linux-m68k.org>
 <20070420.153951.91208263.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: zippel@linux-m68k.org, ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


On Fri, 20 Apr 2007, David Miller wrote:

> That's correct for hardware interrupts.  It will, however, work for
> soft interrupts and similar contexts.

Is there really a significant gain? It seems that such logic would be more 
expensive than an atomic operation.

local_t is saving atomic overhead right? It does no good for cacheline 
contention etc. Adding another int will increase cache footprint. 
Another rat hole?


