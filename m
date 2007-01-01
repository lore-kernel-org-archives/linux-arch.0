Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:45633
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754226AbXAAXEI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jan 2007 18:04:08 -0500
Date: Mon, 01 Jan 2007 15:04:01 -0800 (PST)
Message-Id: <20070101.150401.93385110.davem@davemloft.net>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167669876.5302.60.camel@mulgrave.il.steeleye.com>
References: <Pine.LNX.4.64.0612311249240.4473@woody.osdl.org>
	<20061231.131216.105428418.davem@davemloft.net>
	<1167669876.5302.60.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: torvalds@osdl.org, miklos@szeredi.hu, rmk+lkml@arm.linux.org.uk, arjan@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Mon, 01 Jan 2007 10:44:36 -0600

> Actually, this was proposed here:
> 
> http://marc.theaimsgroup.com/?t=115409754100003
> 
> When I updated the interface to work for the combined VIPT/PIPT cache on
> the latest pariscs.  However, there were no takers for the idea.


I thought this was accepted and Ralf is using it on MIPS?
