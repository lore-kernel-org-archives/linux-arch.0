From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 23:14:00 +0200
Message-ID: <3813680.TbHyagWbHe@wuerfel>
References: <f43656af-050c-82b3-e10d-66be072be320@mellanox.com> <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com> <20160621185048.GR30909@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621185048.GR30909@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday, June 21, 2016 8:50:48 PM CEST Peter Zijlstra wrote:
> 
> > So what's your build process for the cross tools, by the way?  I'm assuming
> > you're not doing a total bootstrap cross-tool build since you'd need minimal
> > kernel headers (linux/errno.h or whatever) in that case.  I assume you're using
> > the host headers to build the cross tool?
> > 
> > So I'm a little confused how the other kernel headers are working out for you,
> > e.g. <arch/icache.h> is referenced when building the tilegx libgcc.
> 
> I've no idea; I use this thing:
> 
>   git://git.infradead.org/users/segher/buildall.git
> 
> Although I've got some local modifications, none are to the actual
> toolchain building part (although I suppose I should send segher a
> patch).
> 
> I have binutils-gdb.git and gcc.bit checkouts and point the buildall
> config to that (both are on latest stable branches binutils-2_26-branch
> and gcc-6-branch resp.). And I point the kernel path to my current
> hacked up tree.
> 
> I don't really rebuild the entire toolchains often, mostly only when I
> really need a new GCC or its getting really old (like I used 5.3.0 for a
> long while).

I think the kernel headers are only needed for building glibc, which
buildall.git doesn't use: it only does the initial stage of creating
a cross-toolchain.

	Arnd
