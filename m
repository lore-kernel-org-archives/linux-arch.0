From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/7] make netfilter use strict integer types
Date: Wed, 25 Feb 2009 16:58:22 -0800
Message-ID: <49A5E92E.8080505@zytor.com>
References: <20090225235138.062045835@arndb.de>	<20090225235515.682333715@arndb.de>	<alpine.LSU.2.00.0902260104220.20789@fbirervta.pbzchgretzou.qr> <20090225.165552.32040707.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34411 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbZBZBFa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 20:05:30 -0500
In-Reply-To: <20090225.165552.32040707.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: jengelh@medozas.de, arnd@arndb.de, sam@ravnborg.org, kyle@infradead.org, mingo@elte.hu, jaswinderrajput@gmail.com, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org

David Miller wrote:
> 
> Disagreed, I think we should have done what Arnd is doing
> a long time ago.
> 
> Ending up with linux/types.h in userspace for these kinds of
> interfaces is already a fore-gone conclusion, it happens
> already whether you like it or not.
> 
> And existing apps will work just fine, since they are already
> getting stdint.h
> 
> As for compile time, since you're already getting linux/types.h
> in your apps it's a non-argument.  But even if it was, what
> are you compiling netfilter utilities on?  A VAX?

I take it that you're OK that we merge Arnd's patchset?

	-hpa
