Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 5 Apr 2005 15:15:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Consolidation of asm/unaligned.h
Message-ID: <20050405141530.GL5227@linux-mips.org>
References: <20050317104744.4be7e550.davem@davemloft.net> <1112586161.7087.3.camel@mulgrave> <20050404104702.GE6016@linux-mips.org> <1112710254.5764.8.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112710254.5764.8.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Apr 05, 2005 at 09:10:54AM -0500, James Bottomley wrote:

> On Mon, 2005-04-04 at 11:47 +0100, Ralf Baechle wrote:
> > This started happening occasionally with gcc 3.4 so it's not just PARISC
> > specific - just rather hard to hit:
> 
> Could you verify that the addition of the consts to the inline function
> size arguments (previously posted patch) fixes this?  If so, I'll send
> the patch on.

I can't reproduce the mistake reported to me unfortunately.  The patch
looks good and doesn't create any new problems on MIPS, so please go ahead.

  Ralf
