From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Fri, 12 Aug 2016 23:15:03 +1000
Message-ID: <20160812231503.3e2e059b@roar.ozlabs.ibm.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
	<20160812123314.GX1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160812123314.GX1041@n2100.armlinux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, Julian Brown <julian@codesourcery.com>, Alan Modra <amodra@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Fri, 12 Aug 2016 13:33:14 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Fri, Aug 12, 2016 at 06:19:17PM +1000, Nicholas Piggin wrote:
> > This patch adds an option which defaults to "y" in cases where we
> > could possibly be running Cortex A8 and using Thumb2 instructions.
> > In reality the workaround might not be required at all for the kernel
> > if virtual instruction memory is linear in physical memory.  
> 
> Hmm.
> 
> The main kernel image is guaranteed to be contiguous in physical memory
> for all sorts of reasons, so this really isn't a concern for the kernel
> itself.

That's what it *seems* like. I wanted to be conservative because I don't
know the architecture nor have actually looked at the errata docs. You
can probably make stronger guarantees to avoid it. Perhaps enabling just
for modules would be workable.


> Modules, however, are a different matter, as they are mapped in using
> individual pages, and are most likely to be non-contiguous in physical
> memory.  The kernel's module linker knows nothing about this errata,
> so it'll generally just fix up the relocations in the most basic of
> ways.
> 
> So, I think we should always use this --no-fix-cortex-a8 option where
> the linker supports it irrespective of whether we're running on a core
> needing this workaround, but we probably need to fix the kernel module
> linker to know about this.

It looks like it would be a bit of work to go that route. The linker of
course would not give you relocations or stubs for the branches you
need them.

Anyway do what you think best with the patch. It seems to eliminate the
link time regression on ARM allyesconfig when using thin archives for
building which is the main thing I was concerned about.

Thanks,
Nick
