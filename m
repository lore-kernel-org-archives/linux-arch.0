Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:64733 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262734AbUCPD7y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2004 22:59:54 -0500
Subject: Re: More DMA API junk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1079408930.2158.408.camel@mulgrave>
References: <1079398383.1968.205.camel@gaston>
	 <1079399555.1804.232.camel@mulgrave>  <1079400742.1968.209.camel@gaston>
	 <1079407473.2069.383.camel@mulgrave>  <1079407959.2348.226.camel@gaston>
	 <1079408930.2158.408.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1079409231.1967.229.camel@gaston>
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 14:53:52 +1100
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


> On your platform, dma_sync_single_range() has a defined meaning for
> streaming mappings.  dma_cache_sync will be a nop, so they're not
> interchangeable.

Ok, so we should make that clear in DMA-API.txt, currently it's
definitely not ;) I'll propose a patch later on if nobody beats me
on this.

> You're confused about what it's used for.  It's designed only to be
> called on memory allocated by dma_alloc_noncoherent() and tells you if
> that API actually returned coherent memory or not.  This was designed
> for ARM which has a limited range of allocateable coherent memory and
> then would need to fail dma_alloc_coherent() or, in the case of
> dma_alloc_noncoherent() begin handing out ordinary kmalloc'd memory.

I still have a problem with the argument. We should pass at least both
the virtual and physical address then. Or also make it clear in the
DMA-API.txt that it is only valid on the result of dma_alloc_noncoherent
in which case it becomes legal for me to hard-wire a result of 1.

Ben
