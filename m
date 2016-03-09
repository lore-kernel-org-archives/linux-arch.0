Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59643 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbcCIMWX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2016 07:22:23 -0500
Date: Wed, 9 Mar 2016 13:22:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: slub: Ensure that slab_unlock() is atomic
Message-ID: <20160309122217.GK6356@twins.programming.kicks-ass.net>
References: <1457447457-25878-1-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1603080857360.4047@east.gentwo.org>
 <56DEF3D3.6080008@synopsys.com>
 <alpine.DEB.2.20.1603081438020.4268@east.gentwo.org>
 <56DFC604.6070407@synopsys.com>
 <20160309101349.GJ6344@twins.programming.kicks-ass.net>
 <56E0024F.4070401@synopsys.com>
 <20160309114054.GJ6356@twins.programming.kicks-ass.net>
 <56E00EB6.4000201@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56E00EB6.4000201@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-parisc@vger.kernel, Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, Noam Camus <noamc@ezchip.com>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Christoph Lameter <cl@linux.com>
Message-ID: <20160309122217.cGLxJh_H_xhZPdsL_ZfL_wji4coNl2bCpnMY4wJ-5cg@z>

On Wed, Mar 09, 2016 at 05:23:26PM +0530, Vineet Gupta wrote:
> > I did not follow through the maze, I think the few archs implementing
> > this simply do not include this file at all.
> > 
> > I'll let the first person that cares about this worry about that :-)
> 
> Ok - that's be me :-) although I really don't see much gains in case of ARC LLSC.
> 
> For us, LD + BCLR + ST is very similar to LLOCK + BCLR + SCOND atleast in terms of
> cache coherency transactions !

The win would be in not having to ever retry the SCOND. Although in this
case, the contending CPU would be doing reads -- which I assume will not
cause a SCOND to fail, so it might indeed not make any difference.
