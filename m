Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:57835 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbXE3BKR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2007 21:10:17 -0400
Date: Tue, 29 May 2007 21:10:15 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: reduce-size-of-task_struct-on-64-bit-machines.patch removed from -mm tree
Message-ID: <20070530011015.GA16354@fattire.cabal.ca>
References: <200705090244.l492i4kH008542@shell0.pdx.osdl.net> <20070529215501.GA15944@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070529215501.GA15944@fattire.cabal.ca>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: wcohen@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, May 29, 2007 at 05:55:01PM -0400, Kyle McMartin wrote:
> Other 64-bit arch maintainers should check that they're using a 32-bit
> load/store on these fields in their assembly now (we were using a
> #define to do word on 32bit and doubleword on 64bit, which broke, badly,
> when these changed.)
> 

Bummer, I just audited everyone else and we're the only people who use
these flags in assembly. Sigh.

Oh well.

Cheers,
	Kyle
