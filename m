From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Tue, 14 Jun 2011 23:34:04 +0100
Message-ID: <20110614223404.GA30057@linux-mips.org>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4DF7C3CA.9050902@zytor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>, Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 14, 2011 at 01:25:46PM -0700, H. Peter Anvin wrote:

> On 06/14/2011 12:08 PM, Ralf Baechle wrote:
> > The PC parallel port Kconfig as acquired one of those messy terms to
> > describe it's architecture dependencies:
> > 
> >        depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
> >                (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> > 
> > This isn't just ugly - it also almost certainly describes the dependencies
> > too coarse grainedly.  This is an attempt at cleaing the mess up.
> > 
> > I tried to faithfully aproximate the old behaviour but the existing
> > behaviour seems inacurate if not wrong for some architectures or platforms.
> > To improve on this I rely on comments from other arch and platforms
> > maintainers.  Any system that can take PCI multi-IO card or has a PC-style
> > parallel port on the mainboard should probably should now do a
> > select HAVE_PC_PARPORT.  And some arch Kconfig files should further
> > restrict the use of HAVE_PC_PARPORT to only those platforms that actually
> > need it.
> > 
> 
> Why on earth restrict it like that?  It's just a device driver, like
> more or less any other device driver...

Some of the older MIPS systems are based on PC chipsets from Intel, OPTi
or others.  On those you can expect the parport_pc driver to actually work.
The ISA/PCI implementations are often between lackluster and pure brokeness
such as with non-functioning I/O port address space.  So I don't want to
run such drivers on such a platforms, things might turn ugly.

Embedded systems often have PCI but no PCI slots or there may even be an
apropriate SuperIO chip in the the system but nothing wired to the parallel
port bits.

And there are systems such as DECstations which have nothing that even
at a parsec's distance has a similarity to (E)ISA or PCI - but still
PARPORT_PC is offered along with 40 other options that depend on it.

There is no point in offering to build something that couldn't possibly be
used.  It just makes the kernel harder to configure and inflates the test
matrix for no good reason.

  Ralf
