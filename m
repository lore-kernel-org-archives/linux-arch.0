Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S270005AbUJTVdF@vger.kernel.org>
Received: from stat16.steeleye.com ([209.192.50.48]:45527 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269043AbUJTVch (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 17:32:37 -0400
Subject: Re: 4level page tables architecture porting
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <OF14AD849F.49584F04-ON42256F33.005B3FB1-42256F33.005BC93B@de.ibm.com>
References: <OF14AD849F.49584F04-ON42256F33.005B3FB1-42256F33.005BC93B@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 20 Oct 2004 16:32:15 -0500
Message-Id: <1098307940.1765.16.camel@mulgrave>
Mime-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2004-10-20 at 11:42, Martin Schwidefsky wrote:
> So you do run a hybrid scheme on parisc, that is interesting. I'm probably
> going to copy some of the parisc code to s390 then. We do want to have this
> for our 31-bit processes on a 64 bit kernel.

Feel free, but the price of our scheme is moderately high.  In order to
fit eight byte pointers in a two level scheme, we only use 32 bit
pointers in the pgd (originally we enforced this by making all our pte
pages come out of GFP_DMA which is under 4GB on parisc, but now we use a
bit shift scheme that theoretically will last us up to the bus physical
limit of the latest pa8800 chipset [several terrabytes at least]); Even
so, our pgd has to be an order 1 allocation (although being one per
process, it's not such a burden).

James
