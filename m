Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 11 Aug 2005 15:51:14 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050811135114.GA6568@lst.de>
References: <20050810080057.GA5295@lst.de> <Pine.LNX.4.61.0508111226530.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508111226530.3743@scrub.home>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 11, 2005 at 12:44:34PM +0200, Roman Zippel wrote:
> No objection really, but I recently reformatted the m68k sys_ptrace() so 
> it would be easier to regenerate your changes on top of this. I can do 
> this for you if we can agree on to merge at least the m68k ptrace changes 
> before this.
> For reference I put the patches at www.xs4all.nl/~zippel/m68k_merge/
> (tf, p_ws, p_c are the relevant patches).

I'll leave m68k out of the patchset for now.  If you have your patches
done when I'm doing the next round of changes in I'll do it atop of
those, else you'll have to redo your changes, bad luck for not syncing
up with mainline.
