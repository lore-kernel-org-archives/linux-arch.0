From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: kbuild now support arch/$ARCH/include - time for
	ARCHs to convert
Date: Wed, 30 Jul 2008 14:26:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807301422380.3316@anakin>
References: <200807300907.25186.arnd@arndb.de>
	<20080728200500.GA14284@uranus.ravnborg.org>
	<48900EE4.8030606@snapgear.com> <3995.1217410495@redhat.com>
Reply-To: uClinux development list <uclinux-dev@uclinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <uclinux-dev-bounces@uclinux.org>
In-Reply-To: <3995.1217410495@redhat.com>
List-Unsubscribe: <http://mailman.uclinux.org/mailman/listinfo/uclinux-dev>,
	<mailto:uclinux-dev-request@uclinux.org?subject=unsubscribe>
List-Archive: <http://mailman.uclinux.org/pipermail/uclinux-dev>
List-Post: <mailto:uclinux-dev@uclinux.org>
List-Help: <mailto:uclinux-dev-request@uclinux.org?subject=help>
List-Subscribe: <http://mailman.uclinux.org/mailman/listinfo/uclinux-dev>,
	<mailto:uclinux-dev-request@uclinux.org?subject=subscribe>
Sender: uclinux-dev-bounces@uclinux.org
Errors-To: uclinux-dev-bounces@uclinux.org
To: David Howells <dhowells@redhat.com>
Cc: linux arch <linux-arch@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, uClinux list <uclinux-dev@uclinux.org>, Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 30 Jul 2008, David Howells wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > I think the more interesting aspect in m68knommu is what happens
> > when asm-m68k gets moved. Does that work as well?
> 
> Can m68knommu be merged into m68k and be made contingent on CONFIG_MMU?  This
> is what FRV does.

Sure it can ;-)

Actually I did a bit of work to add nommu support to m68k to make it
boot on old MMU-less Amigas, but it dates back to the 2.6.8.1 era...

The bigger issue is in those parts that are done differently by m68k and
m68knommu (esp. head.S).

Who's gonna take the work? :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
_______________________________________________
uClinux-dev mailing list
uClinux-dev@uclinux.org
http://mailman.uclinux.org/mailman/listinfo/uclinux-dev
This message was resent by uclinux-dev@uclinux.org
To unsubscribe see:
http://mailman.uclinux.org/mailman/options/uclinux-dev
