Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:59072 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261832AbUCSVFG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 16:05:06 -0500
Date: Fri, 19 Mar 2004 22:05:06 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: pci_map_single return value
Message-Id: <20040319220506.1718cc55.ak@suse.de>
In-Reply-To: <1079730090.1778.1.camel@mulgrave>
References: <20031212155752.GD17683@krispykreme>
	<20031212175104.07dc8444.ak@suse.de>
	<20031212192131.GF17683@krispykreme>
	<20031213220444.4c526afa.davem@redhat.com>
	<20040102120121.GT28023@krispykreme>
	<20040102133454.22daa451.ak@suse.de>
	<20040319001448.GP28212@krispykreme>
	<1079715431.1732.18.camel@mulgrave>
	<20040319105549.1285ef71.davem@redhat.com>
	<1079730090.1778.1.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: davem@redhat.com, anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 19 Mar 2004 16:01:29 -0500
James Bottomley <James.Bottomley@steeleye.com> wrote:

> On Fri, 2004-03-19 at 13:55, David S. Miller wrote:
> > I agree with your concerns, but I don't think I'd go that far.
> > 
> > This error return issue has been around far too long, years in fact.
> > We should make it easier to get this functionality into the tree, not
> > harder.
> > 
> > If there are extra knobs and stuff people need to do in order to what
> > effectively amounts to checking for kmalloc() returning NULL, they
> > are going to be less inclined to do the work.
> 
> I know.  My concern stems more from the fact that we have new
> architectures that have far fewer IOMMU resources.  The primary problem
> is x86-64 with only about 256MB of mapping space.  However on that arch,

Actually 64MB on many systems (128MB AGP aperture and 64MB of that is used 
for AGP)

There are kernel and BIOS options to increase it, but they are often not 
set. The kernel options cost memory and cannot be enabled by default.

> the IOMMU is disabled by default, so it isn't really a problem I
> suppose.

It is effectively disabled when you have ~3GB of memory, but when you have more
and a 32bit only device it will be enabled for that.

-Andi
