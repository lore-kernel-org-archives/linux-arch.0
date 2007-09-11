Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:59462 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXIKN6V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Sep 2007 09:58:21 -0400
Received: from localhost.localdomain ([127.0.0.1]:53198 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022381AbXIKN6T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Sep 2007 14:58:19 +0100
Date: Tue, 11 Sep 2007 14:58:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Removal of dma_cache_* functions?
Message-ID: <20070911135817.GA1285@linux-mips.org>
References: <20070904115615.GA14986@linux-mips.org> <20070904124212.GR14130@parisc-linux.org> <1188910630.3435.2.camel@localhost.localdomain> <20070904130707.GA16556@linux-mips.org> <yq0sl5le2p2.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0sl5le2p2.fsf@jaguar.mkp.net>
Sender: linux-arch-owner@vger.kernel.org
To: Jes Sorensen <jes@sgi.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 11, 2007 at 09:44:57AM -0400, Jes Sorensen wrote:

> Only issue I could think off would be the m68k drivers, but I don't
> know if that ever migrated to the MIPS API or stayed with the old m68k
> one - Geert and comments?

That would only apply to out of tree drivers.  With the patch applied
git grep -E -w -l 'dma_cache_(wback|wback_inv|inv)' only finds:

arch/mips/au1000/common/dbdma.c
arch/mips/jazz/jazzdma.c
arch/mips/mm/dma-default.c
drivers/net/sgiseeq.c
drivers/scsi/dec_esp.c
include/asm-mips/floppy.h
include/asm-mips/io.h

For sgiseeq there already is a patch in flight.

  Ralf
