Return-Path: <James.Bottomley@steeleye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:18357 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261160AbUCSVBj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 16:01:39 -0500
Subject: Re: pci_map_single return value
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20040319105549.1285ef71.davem@redhat.com>
References: <20031212155752.GD17683@krispykreme>
	<20031212175104.07dc8444.ak@suse.de> <20031212192131.GF17683@krispykreme>
	<20031213220444.4c526afa.davem@redhat.com>
	<20040102120121.GT28023@krispykreme> <20040102133454.22daa451.ak@suse.de>
	<20040319001448.GP28212@krispykreme> <1079715431.1732.18.camel@mulgrave>
	<20040319105549.1285ef71.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 19 Mar 2004 16:01:29 -0500
Message-Id: <1079730090.1778.1.camel@mulgrave>
Mime-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: anton@samba.org, ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2004-03-19 at 13:55, David S. Miller wrote:
> I agree with your concerns, but I don't think I'd go that far.
> 
> This error return issue has been around far too long, years in fact.
> We should make it easier to get this functionality into the tree, not
> harder.
> 
> If there are extra knobs and stuff people need to do in order to what
> effectively amounts to checking for kmalloc() returning NULL, they
> are going to be less inclined to do the work.

I know.  My concern stems more from the fact that we have new
architectures that have far fewer IOMMU resources.  The primary problem
is x86-64 with only about 256MB of mapping space.  However on that arch,
the IOMMU is disabled by default, so it isn't really a problem I
suppose.

James
