Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:43957 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbXIDNHM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2007 09:07:12 -0400
Received: from localhost.localdomain ([127.0.0.1]:46234 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024757AbXIDNHL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Sep 2007 14:07:11 +0100
Date: Tue, 4 Sep 2007 14:07:08 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Removal of dma_cache_* functions?
Message-ID: <20070904130707.GA16556@linux-mips.org>
References: <20070904115615.GA14986@linux-mips.org> <20070904124212.GR14130@parisc-linux.org> <1188910630.3435.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1188910630.3435.2.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 04, 2007 at 01:57:10PM +0100, James Bottomley wrote:

> On Tue, 2007-09-04 at 06:42 -0600, Matthew Wilcox wrote:
> > On Tue, Sep 04, 2007 at 12:56:16PM +0100, Ralf Baechle wrote:
> > > Most architectures implement the dma_cache_wback, dma_cache_wback_inv
> > > and dma_cache_wback_inv functions even though there is the more modern
> > > and much better designed DMA API and only two MIPS-specific users (one of
> > > which I just fixed) do remain.  So should we finally start removing it?
> > 
> > There's still some users in arch/, but yes, let's remove it from the
> > arches that don't use it internally.
> 
> There's the updated dma_cache_sync() API, which you need to keep because
> the parisc lasi scsi and network drivers rely on it for our fully
> incoherent boxes.

I wasn't thinking of touching dma_cache_sync, only the three mentioned
mostly unused ones.

  Ralf
