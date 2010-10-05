From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/47] Sparse irq rework
Date: Tue, 5 Oct 2010 12:22:24 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1010051219580.2556@localhost6.localdomain6>
References: <20100930221351.682772535@linutronix.de> <20101003112312.GB9844@angua.secretlab.ca> <20101003112920.GB32736@n2100.arm.linux.org.uk> <AANLkTingVuhgdaLZ8U3bM+F2vZJ_kScwKqNtHW=g6DcH@mail.gmail.com>
 <alpine.LFD.2.00.1010031544340.14550@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1010031544340.14550@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

On Sun, 3 Oct 2010, Thomas Gleixner wrote:
> On Sun, 3 Oct 2010, Grant Likely wrote:
> > Okay, patch 14 looks good to me too (including Yinghai's comment).
> > The new allocator seems sane, and I didn't see any obvious errors in
> > patches 16-47.  I've not tested any of this yet.  Hopefully I'll be
> > able to carve out some time to do so early this week.
> 
> Wait until I pushed out a fixed tree. In meantime I found out how I
> managed to screw up the quilt series :(
> 
> Will post, once it's ready.

Pushed out an updated tree to

 git://git.kernel.org/pub/scm/linux/kernel/git/tglx/linux-2.6-sparse-irq.git master

Thanks,

	tglx
