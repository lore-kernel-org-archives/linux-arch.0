Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262633AbUKEJV6@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:12258 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262631AbUKEJV6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Nov 2004 04:21:58 -0500
Date: Fri, 5 Nov 2004 10:18:24 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: Fw: 2.6.10-rc1-mm3
Message-ID: <20041105091824.GE16992@wotan.suse.de>
References: <20041105005257.2dc4408e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105005257.2dc4408e.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Nov 05, 2004 at 12:52:57AM -0800, Andrew Morton wrote:
> 
> Guys, just a heads up on the 4-level pagetable stuff.  If you haven't yet
> checked it out, please do so.

I think I converted everybody except for UML and mips, but not every architecture 
has been compiled or booted.  The changes are quite straight forward 
if something is still needed.


This was my latest status. Converted means I only grepped
for pgd, no test compile.

i386		works with 2 and 3 levels
x86-64		works with 4 levels
ia64		works with 3 levels 
ppc64		works with 3 levels (thanks to dwmw2) 
ppc32		works with 2 levels (thanks to hch, Mikael P. for testing)
s390/s390x	works with 3 levels (thanks to Martin S.) 
sh		converted, but doesn't compile for other reasons
alpha		works with 3 levels (thanks to viro for testing) 
sparc64		works (thanks to DaveM for testing)
mips/mips64	not done, Ralf stated it was ok to leave it to him.
parisc		works on 32,64bit (thanks to Kyle M. for testing) 
arm		converted
sh64		converted
sparc32		converted
cris		works (thanks to Mikael Starvik)
m32r		converted


-Andi
