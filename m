Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58542
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750925AbWCSXm0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 18:42:26 -0500
Date: Sun, 19 Mar 2006 15:42:23 -0800 (PST)
Message-Id: <20060319.154223.21784367.davem@davemloft.net>
Subject: Re: Potential problem with the page_mapping macro and
 flush_dcache_page()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1142811577.3240.75.camel@mulgrave.il.steeleye.com>
References: <1142803783.3240.64.camel@mulgrave.il.steeleye.com>
	<20060319.140124.69326977.davem@davemloft.net>
	<1142811577.3240.75.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sun, 19 Mar 2006 17:39:36 -0600

> > What am I missing?
> 
> Nothing; it's always irked me that we need all these extra coherence
> protocols for the PA VIPT cache because it's so large with such low
> associativity.  But it also makes us a good test case for the linux
> API ...

Ok, thanks for the explanation.  It is horrible though :)
