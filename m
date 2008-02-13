Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out2.tiscali.nl ([195.241.79.177]:46853 "EHLO
	smtp-out2.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbYBMRaA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2008 12:30:00 -0500
Message-ID: <47B32510.20200@tiscali.nl>
Date: Wed, 13 Feb 2008 18:12:48 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
References: <20080211203146.3d28d1a0@laptopd505.fenrus.org> <20080212044314.GA4888@kroah.com> <20080211211751.3e265754@laptopd505.fenrus.org> <20080211.221126.230471463.davem@davemloft.net> <47B1CB08.4020101@garzik.org> <alpine.LFD.1.00.0802120847500.2920@woody.linux-foundation.org> <20080212174824.GA1919@kroah.com> <alpine.LFD.1.00.0802121011280.2920@woody.linux-foundation.org> <20080212191552.GA20883@kroah.com> <alpine.LFD.1.00.0802121133210.2920@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0802121133210.2920@woody.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>, arjan@infradead.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

Linus Torvalds wrote:
> 
> On Tue, 12 Feb 2008, Greg KH wrote:
>>> That's the point.
>> Not it isn't.  To quote you a number of years ago:
>> 	"Linux is evolution, not intelligent design"
> 
> Umm. Have you read a lot of books on evolution?
> 
> It doesn't sound like you have.
> 
> The fact is, evolution often does odd (and "suboptimal") things exactly 
> because it does incremental changes that DO NOT BREAK at any point.

This is not entirely true if the pressure for changes are removed. For 
instance in mammals the bones in the ear are what used to be gills in fish.
When fish became amphibians the gills weren't needed as much and evolution
took a side path.

> The examples are legion. The mammalian eye has the retina "backwards", 
> with the blind spot appearing because the fundmanetal infrastructure (the 
> optical nerves) actually being in *front* of the light sensor and needing 
> a hole in the retina to get the information (and blood flow) to go to the 
> brain!
> 
> In other words, exactly *because* evolution requires "bisectability" (any 
> non-viable point in between is a dead end by definition) and does things 
> incrementally, it doesn't do big flips. It fixes the problems on an 
> incremental scale both when it comes to the details and when it comes to 
> both "details" (actual protein-coding genes that code directly for some 
> expression) and "infrastructure" (homeobox and non-coding genes).

In nature there is a lot of duplication: several copies of genes can exist
and different copies may have a distinct evolution. There is also a lot of
'junk' DNA that doesn't code for anything (although it may have regulating
functions). In there some copies of genes may remain that are inactivated,
as well as parts of virusses, slowly obtaining random mutations because
there is no pressure on the evolution of them. Some may eventually become
active again and have different functions.

The duplication also often ensures there is fallback when random mutations
are acquired and a protein is knocked out. Besides the two chromosomes
several proteins also can have overlapping functions. The result is more
like a balance. 
 
Evolution in nature and changes in code are different because in code junk
and bugs are constantly removed. In biology junk is allowed and may provide
a pool for future development. Linux development is intended and not
survival.
