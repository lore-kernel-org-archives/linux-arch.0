Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45]:61898 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265809AbUFSEMJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 19 Jun 2004 00:12:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16595.48028.925656.212915@cargo.ozlabs.ibm.com>
Date: Sat, 19 Jun 2004 14:05:48 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: Accessing memory remote across the bus in the same way as local
	memory
In-Reply-To: <1087601198.2134.206.camel@mulgrave>
References: <1087601198.2134.206.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

James Bottomley writes:

> The question has come up [in the DMA API issues thread on lkml] of
> whether we can access on chip memory areas as though they were normal
> memory (i.e. use normal reads and writes to access it).
> 
> The memory regions in question would have to be accessible via MMIO
> cycles on the bus and be aligned and sized as multiples of PAGE_SIZE.
> 
> The question is given the constraints, can we pull page table tricks on
> every platform to make this bus remote memory look like real memory?

Not on iSeries machines (ppc64 machines running OS/400).  There we
have to do a hypervisor call for every access to PCI memory or I/O
space, unfortunately.  Fortunately people don't tend to put arbitrary
PCI adaptors in iSeries boxes, and they don't run X servers.  Linux
partitions on iSeries machines are mostly used for things like
firewalls and web servers.

What did you want to be able to do this for?  It probably isn't the
end of the world if whatever you want to do with this doesn't work on
iSeries.

Paul.
