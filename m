Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268828AbUHLVgn@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47586 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268576AbUHLVeF
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2004 17:34:05 -0400
Date: Thu, 12 Aug 2004 22:34:03 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: Re: clear_user_highpage()
Message-ID: <20040812213403.GE12936@parcelfarce.linux.theplanet.co.uk>
References: <20040811161537.5e24c2b6.davem@redhat.com> <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040811165307.46ff1eb6.davem@redhat.com> <Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org> <20040812020825.GA14411@wotan.suse.de> <20040811194545.0034428b.davem@redhat.com> <20040812110924.0713f5d9.ak@suse.de> <20040812125059.298ae914.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812125059.298ae914.davem@redhat.com>
Sender: <willy@www.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 12, 2004 at 12:50:59PM -0700, David S. Miller wrote:
> Is there any other platform that has the same kind of block
> stores sparc64 does (basically use L2 cache if line present,
> else bypass L2 cache for the store and do not allocate L2
> cache lines for the data)?  I bet ia64 does have something
> like this.

Yes, almost exactly.  You can specify the "nta" hint to stores which means
"non-temporal at all levels".  If the cache-line is already present in
the cache at any level, it will not be demoted, but if it isn't present,
it'll bypass the cache entirely.

If you want to specifically retain a cache line at a particular level
in cache, you can prefetch it into that level, then use .nta and the
line won't move.

That's all according to the architecture reference anyway.  I don't know
how much of that processors actually implement and how much they think
they know better than the programmer ;-)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
