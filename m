Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 5 Apr 2005 16:11:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Consolidation of asm/unaligned.h
Message-ID: <20050405151151.GN5227@linux-mips.org>
References: <20050317104744.4be7e550.davem@davemloft.net> <1112586161.7087.3.camel@mulgrave> <20050404104702.GE6016@linux-mips.org> <1112710254.5764.8.camel@mulgrave> <20050405150218.GD16157@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405150218.GD16157@parcelfarce.linux.theplanet.co.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: James Bottomley <James.Bottomley@steeleye.com>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Apr 05, 2005 at 04:02:18PM +0100, Matthew Wilcox wrote:

> > Could you verify that the addition of the consts to the inline function
> > size arguments (previously posted patch) fixes this?  If so, I'll send
> > the patch on.
> 
> FWIW, adding consts doesn't help gcc-3.0.  I don't have a problem with
> forcing people to upgrade from 3.0 to 3.3, I just wanted to be sure
> everyone's aware of the problem.

3.0 has been a significant source of trouble on MIPS.  Fortunately 3.0
and 3.1 seems to have died out already so I don't need to force anybody :)

  Ralf
