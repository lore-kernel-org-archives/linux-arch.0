Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:38617 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753311AbXIDM5O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2007 08:57:14 -0400
Subject: Re: Removal of dma_cache_* functions?
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20070904124212.GR14130@parisc-linux.org>
References: <20070904115615.GA14986@linux-mips.org>
	 <20070904124212.GR14130@parisc-linux.org>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 13:57:10 +0100
Message-Id: <1188910630.3435.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-09-04 at 06:42 -0600, Matthew Wilcox wrote:
> On Tue, Sep 04, 2007 at 12:56:16PM +0100, Ralf Baechle wrote:
> > Most architectures implement the dma_cache_wback, dma_cache_wback_inv
> > and dma_cache_wback_inv functions even though there is the more modern
> > and much better designed DMA API and only two MIPS-specific users (one of
> > which I just fixed) do remain.  So should we finally start removing it?
> 
> There's still some users in arch/, but yes, let's remove it from the
> arches that don't use it internally.

There's the updated dma_cache_sync() API, which you need to keep because
the parisc lasi scsi and network drivers rely on it for our fully
incoherent boxes.

James


