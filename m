From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Date: Wed, 13 Feb 2019 11:31:27 -0800
Message-ID: <20190213193127.GH4240@linux.ibm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
 <20190213172047.GH6346@brain-police>
 <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
 <20190213183314.GB32494@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7D4FF0DE@ORSMSX110.amr.corp.intel.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D4FF0DE@ORSMSX110.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 13, 2019 at 06:43:41PM +0000, Luck, Tony wrote:
> > I think the last time this came up, it was said that those people still
> > running Linux on Itanium were running old distro kernels, not upstream.
> >
> > So yeah, we could probably do whatever and nobody would ever notice,
> > except maybe Al, who is rumoured to still have an ia64 :-)
> 
> I haven't heard of anyone taking upstream kernels and actually using them
> for production work in a long time. It's mostly just a few folks keeping ia64
> alive "just because" these days.  I doubt any of them have an SGI Altix
> to test on (so realistically Altix was probably broken upstream many releases
> ago).

That would require a well-healed computer collector, wouldn't it?  Just to
run the thing.  ;-)

								Thanx, Paul
