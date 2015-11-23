From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
Date: Mon, 23 Nov 2015 21:58:22 +0100
Message-ID: <4102055.db40h1joXM@wuerfel>
References: <5868782.RxZY0W5S4d@wuerfel> <20151123201635.GB27783@x>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:64856 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbbKWU6w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2015 15:58:52 -0500
In-Reply-To: <20151123201635.GB27783@x>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk

On Monday 23 November 2015 12:16:36 Josh Triplett wrote:
> Two comments inline below.
> 
> On Mon, Nov 23, 2015 at 05:25:28PM +0100, Arnd Bergmann wrote:
> > When CONFIG_BUG is disabled, BUG_ON() will only evaluate the condition,
> > but will not actually stop the current thread. GCC warns about a couple
> > of BUG_ON() users where this actually leads to further undefined
> > behavior:
> > 
> > include/linux/ceph/osdmap.h: In function 'ceph_can_shift_osds':
> > include/linux/ceph/osdmap.h:54:1: warning: control reaches end of non-void function
> > fs/ext4/inode.c: In function 'ext4_map_blocks':
> > fs/ext4/inode.c:548:5: warning: 'retval' may be used uninitialized in this function
> > drivers/mfd/db8500-prcmu.c: In function 'prcmu_config_clkout':
> > drivers/mfd/db8500-prcmu.c:762:10: warning: 'div_mask' may be used uninitialized in this function
> > drivers/mfd/db8500-prcmu.c:769:13: warning: 'mask' may be used uninitialized in this function
> > drivers/mfd/db8500-prcmu.c:757:7: warning: 'bits' may be used uninitialized in this function
> > drivers/tty/serial/8250/8250_core.c: In function 'univ8250_release_irq':
> > drivers/tty/serial/8250/8250_core.c:252:18: warning: 'i' may be used uninitialized in this function
> > drivers/tty/serial/8250/8250_core.c:235:19: note: 'i' was declared here
> 
> Eliminating the spurious warnings seems like a good reason to do this.

Yes, that's where I initially came from anyway. Note that they are
mostly not spurious, they warn about something actually going really
wrong here (undefined behavior) though only after we noticed that it was
already pretty wrong (BUG_ON).

> > There is an obvious conflict of interest here: on the one hand, someone
> > who disables CONFIG_BUG() will want the kernel to be as small as possible
> > and doesn't care about printing error messages to a console that nobody
> > looks at. On the other hand, running into a BUG_ON() condition means that
> > something has gone wrong, and we probably want to also stop doing things
> > that might cause data corruption.
> 
> Seems like you should adjust the Kconfig description for 'config BUG' in
> init/Kconfig to account for BUG/BUG_ON still stopping the machine.

Yes, probably a good idea.

> (For that matter, I can't help but wonder if we could then consolidate
> CONFIG_BUG and CONFIG_DEBUG_BUGVERBOSE, since we now only semantically
> change whether and how much we print.  However, that could happen in
> another patch.)

I think it still makes sense to keep them separate. With CONFIG_BUG=n,
we get no bug_table at all, while with CONFIG_BUGVERBOSE=n, we avoid
most of the data fields of the bug table but still try to print a
message tellung us that we hit a BUG().

> > This patch picks the second choice, and changes the NOP to BUG(), which
> > normally stops the execution of the current thread in some form (endless
> > loop or a trap). This follows the logic we applied in a4b5d580e078 ("bug:
> > Make BUG() always stop the machine").
> > 
> > For ARM multi_v7_defconfig, the size slightly increases:
> > 
> > section		CONFIG_BUG=y	CONFIG_BUG=n	CONFIG_BUG=n+patch
> > 
> >   .text            8320248   |     8180944   |     8207688
> >   .rodata          3633720   |     3567144   |     3570648
> >   __bug_table        32508   |         ---   |         ---
> >   __modver             692   |        1584   |        2176
> >   .init.text        558132   |      548300   |      550088
> >   .exit.text         12380   |       12256   |       12380
> >   .data            1016672   |     1016064   |     1016128
> >   Total           14622556   |    14374510   |    14407326
> > 
> > So instead of saving 1.70% of the total image size, we only save 1.48%
> 
> Could you please include numbers for tinyconfig as well?  Percentages
> get larger when the numbers get smaller.

not sure where I can find tinyconfig, this is what I get for ARM allnoconfig
(only totals, let me know if you need more details):

original:		961307
patched:		969167 (+0.82%)
CONFIG_BUG:		994695 (+3.36%)
CONFIG_BUGVERBOSE:    1003379 (+4.20%)

looking at the sections, my patch adds 3688 bytes to .text and the __modver
section grows from 0 to 4088 bytes, which is something I can't explain
at the moment, there doesn't really seem to be anything in it.

Note that this kernel also includes another patch I resubmitted the
other day at

http://permalink.gmane.org/gmane.linux.ports.arm.kernel/455995

Without that patch, the difference would be slightly bigger as we would
more often need two instructions for a BUG_ON rather than one.

> > by turning off CONFIG_BUG, but in return we can ensure that we don't run
> > into cases of uninitialized variable or return code uses when something
> > bad happens. Aside from that, we significantly reduce the number of
> > warnings in randconfig builds, which makes it easier to fix the warnings
> > about other problems.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> > index 630dd2372238..58bd1f08c5c7 100644
> > --- a/include/asm-generic/bug.h
> > +++ b/include/asm-generic/bug.h
> > @@ -142,7 +142,7 @@ extern void warn_slowpath_null(const char *file, const int line);
> >  #endif
> >  
> >  #ifndef HAVE_ARCH_BUG_ON
> > -#define BUG_ON(condition) do { if (condition) ; } while (0)
> > +#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
> 
> This makes BUG_ON in the !CONFIG_BUG case almost identical to the
> CONFIG_BUG=y case, except for the use of unlikely(condition), which this
> ought to do as well.
> 
> Given that, could you pull the definition *out* of the #ifdef/#else for
> CONFIG_BUG entirely, and define it the same way in both cases?

Yes, I thought about that already and decided to keep the patch simple
instead. I can do that of course once we get consensus on the general
approach.

	Arnd
