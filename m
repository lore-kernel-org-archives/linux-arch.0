From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Date: Mon, 8 Aug 2016 00:12:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1608080004050.17623@knanqh.ubzr>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com> <1470399123-8455-3-git-send-email-npiggin@gmail.com> <alpine.LFD.2.20.1608070018460.17623@knanqh.ubzr> <20160808134235.6f20eacb@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160808134235.6f20eacb@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, 8 Aug 2016, Nicholas Piggin wrote:

> On Sun, 7 Aug 2016 01:33:45 -0400 (EDT)
> Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> 
> > On Fri, 5 Aug 2016, Nicholas Piggin wrote:
> > 
> > > Introduce LINKER_DCE option for architectures to select if they want
> > > to build with -ffunction-sections, -fdata-sections, and link with
> > > --gc-sections. It requires some work (documented) to ensure all
> > > unreferenced entrypoints are live, and requires toolchain and
> > > build verification, so it is made a per-arch option for now.
> > > 
> > > On a random powerpc64le build, this yelds a significant size saving,
> > > it boots and runs fine, but there is a lot I haven't tested as yet,
> > > so these savings may be reduced if there are bugs in the link.
> > > 
> > >     text      data        bss        dec   filename
> > > 11169741   1180744    1923176	14273661   vmlinux
> > > 10445269   1004127    1919707	13369103   vmlinux.dce
> > > 
> > > ~700K text, ~170K data, 6% removed from kernel image size.
> > > 
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > 
> > I played with that too. However this needs distinct sections for 
> > exception tables and the like otherwise the backward references from the 
> > final exception table to those functions responsible for those exception 
> > entries has the effect of pulling in all those functions even if their 
> > entry point is never referenced, making --gc-sections less effective.  
> > I managed to fix this only with a change to gas (accepted upstream).
> > 
> > But once that is solved, you then have the missing forward reference 
> > problem i.e. nothing actually references those individual exception 
> > entry sections and ld happily drops them all. Having a KEEP() on each of 
> > them is unworkable and defeats the purpose anyway.  That requires a 
> > dummy reloc to trick ld into pulling in those sections when the parent 
> > section is also pulled in.
> 
> Right, although we don't *need* those things just for enabling
> --gc-sections, do we? It may not be 100% optimal, but it's enough
> to avoid the regression when switching to --whole-archive build
> option.

Oh absolutely.

> Your results are impressive, and I don't want to stand in the way of
> either LTO or improving accuracy of --gc-sections. But both are things
> that can be built on top of this patch, I think.

Indeed.  Those patches are certainly welcome. They represent half of the 
job already.  I just wanted to provide some insight about the whole 
picture in case someone else notices those flaws I have identified.


Nicolas
