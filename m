Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261234AbUJTOm3@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:27281 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267852AbUJTOkA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 10:40:00 -0400
Date: Wed, 20 Oct 2004 16:39:49 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: 4level page tables architecture porting
Message-ID: <20041020143949.GB32257@wotan.suse.de>
References: <20041020131340.GA5282@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020131340.GA5282@mschwid3.boeblingen.de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Oct 20, 2004 at 03:13:40PM +0200, Martin Schwidefsky wrote:
> Hi Andy,
> 
> > If anybody could do the conversion for their port and send me
> > the diff it would be very appreciated. It should be quite straight forward.
> 
> 4TB is enough for 64-bit s390 for the time being. We'll use the nopml4
> defines for 31 & 64 bit. Patch attached.

Thanks, Martin. I added the patch to the patchkit.

BTW
The motivation for really large address space spaces is actually not really
to use that much memory, but just to be able to mmap extremly large
files. The original reason I started this was because some users wanted
to mmap 300GB files and it didn't work because the shared
libraries were in the way. So if you consider that it may be worth
enlarging it at some point anyways. I assume S390s have typically
more storage than x86-64 machines ;-)

-Andi
