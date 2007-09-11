Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:60354 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbXIKNo6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Sep 2007 09:44:58 -0400
Subject: Re: Removal of dma_cache_* functions?
References: <20070904115615.GA14986@linux-mips.org>
	<20070904124212.GR14130@parisc-linux.org>
	<1188910630.3435.2.camel@localhost.localdomain>
	<20070904130707.GA16556@linux-mips.org>
From: Jes Sorensen <jes@sgi.com>
Date: 11 Sep 2007 09:44:57 -0400
In-Reply-To: <20070904130707.GA16556@linux-mips.org>
Message-ID: <yq0sl5le2p2.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <linux-arch.vger.kernel.org>

>>>>> "Ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

Ralf> On Tue, Sep 04, 2007 at 01:57:10PM +0100, James Bottomley wrote:
>> On Tue, 2007-09-04 at 06:42 -0600, Matthew Wilcox wrote:
>> > On Tue, Sep 04, 2007 at 12:56:16PM +0100, Ralf Baechle wrote:
>> > > Most architectures implement the dma_cache_wback,
>> dma_cache_wback_inv > > and dma_cache_wback_inv functions even
>> though there is the more modern > > and much better designed DMA
>> API and only two MIPS-specific users (one of > > which I just
>> fixed) do remain.  So should we finally start removing it?
>> > 
>> > There's still some users in arch/, but yes, let's remove it from
>> the > arches that don't use it internally.
>> 
>> There's the updated dma_cache_sync() API, which you need to keep
>> because the parisc lasi scsi and network drivers rely on it for our
>> fully incoherent boxes.

Ralf> I wasn't thinking of touching dma_cache_sync, only the three
Ralf> mentioned mostly unused ones.

Ralf,

Only issue I could think off would be the m68k drivers, but I don't
know if that ever migrated to the MIPS API or stayed with the old m68k
one - Geert and comments?

Cheers,
Jes
