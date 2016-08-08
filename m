From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives instead of ld -r
Date: Mon, 08 Aug 2016 11:18:44 +0200
Message-ID: <20344093.JroaIWMd3z@wuerfel>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com> <20160806201045.GA25821@ravnborg.org> <20160808132532.3ce8c0b6@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160808132532.3ce8c0b6@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Monday, August 8, 2016 1:25:32 PM CEST Nicholas Piggin wrote:
> On Sat, 6 Aug 2016 22:10:45 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > Hi Nicholas.
> > 
> > On Fri, Aug 05, 2016 at 10:11:59PM +1000, Nicholas Piggin wrote:
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > 
> > > ld -r is an incremental link used to create built-in.o files in build
> > > subdirectories. It produces relocatable object files containing all
> > > its input files, and these are are then pulled together and relocated
> > > in the final link. Aside from the bloat, this constrains the final
> > > link relocations, which has bitten large powerpc builds with
> > > unresolvable relocations in the final link.
> > > 
> > > Alan Modra has recommended the kernel use thin archives for linking.
> > > This is an alternative and means that the linker has more information
> > > available to it when it links the kernel.
> > > 
> > > This patch enables a config option architectures can select,  
> > If we want to do this, then I suggest to make the logic reverse.
> > Architectures that for some reasons cannot use this should
> > have the possibility to avoid it. But let it be enabled by default.
> 
> I was thinking the build matrix (architectures x build options x toolchains)
> is a bit too large to switch it for everybody. I've far from even tested it
> for a fraction of powerpc builds. I would prefer arch maintainers to switch
> it themselves, but I do hope we can move everybody and just remove the old
> method within a few releases.
> 
> But I'm happy to go with whatever arch and kbuild maintainers prefer, so I
> appreciate any discussion on it.

How about making the option visible for everyone with CONFIG_EXPERT?

That way you don't get it by default, but you do get it with randconfig
and allmodconfig build testing.

	Arnd
