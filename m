From: David Miller <davem@davemloft.net>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 14:03:53 -0800 (PST)
Message-ID: <20091210.140353.219266447.davem@davemloft.net>
References: <1260478776.2457.141.camel@mulgrave.site>
	<20091211002700.0600d327.isloginov@gmail.com>
	<1260482418.2457.208.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37182
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761777AbZLJWDr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Dec 2009 17:03:47 -0500
In-Reply-To: <1260482418.2457.208.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James.Bottomley@HansenPartnership.com
Cc: isloginov@gmail.com, jens.axboe@oracle.com, linux-arch@vger.kernel.org

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 10 Dec 2009 16:00:18 -0600

> On Fri, 2009-12-11 at 00:27 +0300, Ilya Loginov wrote:
>> On Thu, 10 Dec 2009 14:59:36 -0600
>> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>> 
>> > To fix mips, you just need a
>> > flush_kernel_dcache_page() in slram_read so that the alias is updated
>> > after the memcpy. 
>> 
>> I think you right. But! If we choose this way:
>> 
>> First. We need to realize flush_kernel_dcache_page() for many
>> architectures. Am I right?
> 
> Actually, I think only sparc and mips need it.  It's only needed for an
> aliasing architecture.  Next, it's only used for pio drivers, so if the
> platform never uses a pio driver, it can get away without having this
> (that's the sparc case, I think).

Sparc has PIO drivers, namely IDE, and we have special flushes inserted
into the IDE string PIO routines to handle that case.
