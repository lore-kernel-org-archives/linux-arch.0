Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 5 Apr 2005 16:02:18 +0100
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Consolidation of asm/unaligned.h
Message-ID: <20050405150218.GD16157@parcelfarce.linux.theplanet.co.uk>
References: <20050317104744.4be7e550.davem@davemloft.net> <1112586161.7087.3.camel@mulgrave> <20050404104702.GE6016@linux-mips.org> <1112710254.5764.8.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112710254.5764.8.camel@mulgrave>
Sender: <willy@www.linux.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Apr 05, 2005 at 09:10:54AM -0500, James Bottomley wrote:
> On Mon, 2005-04-04 at 11:47 +0100, Ralf Baechle wrote:
> > This started happening occasionally with gcc 3.4 so it's not just PARISC
> > specific - just rather hard to hit:
> 
> Could you verify that the addition of the consts to the inline function
> size arguments (previously posted patch) fixes this?  If so, I'll send
> the patch on.

FWIW, adding consts doesn't help gcc-3.0.  I don't have a problem with
forcing people to upgrade from 3.0 to 3.3, I just wanted to be sure
everyone's aware of the problem.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
