From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Wed, 23 Nov 2016 09:33:32 +0000
Message-ID: <20161123093332.GB14217@n2100.armlinux.org.uk>
References: <20161122110557.1533467-1-arnd@arndb.de>
 <alpine.LFD.2.20.1611221106410.1814@knanqh.ubzr>
 <20161123120436.18dc21e7@roar.ozlabs.ibm.com>
 <alpine.LFD.2.20.1611222030050.1814@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1611222030050.1814@knanqh.ubzr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, regressions@leemhuis.info, viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 22, 2016 at 08:35:48PM -0500, Nicolas Pitre wrote:
> On Wed, 23 Nov 2016, Nicholas Piggin wrote:
> =

> > On Tue, 22 Nov 2016 11:34:48 -0500 (EST)
> > Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > =

> > > On Tue, 22 Nov 2016, Arnd Bergmann wrote:
> > > =

> > > > This adds an asm/asm-prototypes.h header for ARM to fix the broken =
symbol
> > > > versioning for symbols exported from assembler files.
> > > > =

> > > > I couldn't find the correct prototypes for the compiler builtins,
> > > > so I went with the fake 'void f(void)' prototypes that we had
> > > > before, restoring the state before they were moved.
> > > > =

> > > > Originally I assumed that the problem was just a harmless warning
> > > > in unusual configurations, but as Uwe found, we actually need this
> > > > to load most modules when symbol versioning is enabled, as it is
> > > > in many distro kernels.
> > > > =

> > > > Cc: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> > > > Fixes: 4dd1837d7589 ("arm: move exports to definitions")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > > Compared to the earlier version, I dropped the changes to the
> > > > csumpartial files, which now get handled correctly by Kbuild
> > > > even when the export comes from a macro, and I also dropped the
> > > > changes to the bitops files, which were already fixed in a
> > > > patch from Nico.
> > > > =

> > > > The patch applies cleanly on top of the rmk/fixes tree but has
> > > > no effect there, as it also needs 4efca4ed05cb ("kbuild: modversions
> > > > for EXPORT_SYMBOL() for asm") and cc6acc11cad1 ("kbuild: be more
> > > > careful about matching preprocessed asm ___EXPORT_SYMBOL").
> > > > =

> > > > With the combination of rmk/fixes, torvalds/master and these two
> > > > patches, symbol versioning works again on ARM. As it is still
> > > > broken on almost all other architectures (powerpc is fixed,
> > > > x86 has a patch), I wonder if we should make CONFIG_MODVERSIONS
> > > > as broken for everything else.  =

> > > =

> > > I'm not sure I like this at all.
> > > =

> > > The goal for moving EXPORT_SYMBOL() to assembly code where symbols we=
re =

> > > defined is to make things close together and avoid those centralized =

> > > list of symbols that you can easily miss when modifying the actual co=
de.
> > =

> > Right.
> > =

> > > =

> > > This series is therefore bringing back a centralized list of symbols =
in =

> > > a slightly different form, nullifying the advantages from having move=
d =

> > > EXPORT_SYMBOL() to asm code.  To me this looks like a big step backwa=
rd.
> > =

> > Exported symbols have C declarations in headers already. For the most
> > part, anyway -- these ones Arnd adds are for compiler runtime which is
> > why some architectures haven't had the prototypes.
> =

> Hmmm. That's right.  That makes it much more justifiable.
> My main objection is withdrawn.

I don't see it makes any difference - the armksyms.c originally had
the same:

-#include <linux/export.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/cryptohash.h>
-#include <linux/delay.h>
-#include <linux/in6.h>
-#include <linux/syscalls.h>
-#include <linux/uaccess.h>
-#include <linux/io.h>
-#include <linux/arm-smccc.h>
-
-#include <asm/checksum.h>
-#include <asm/ftrace.h>

followed by prototypes for the GCC internal functions, and:

-extern void fpundefinstr(void);
-
-void mmioset(void *, unsigned int, size_t);
-void mmiocpy(void *, const void *, size_t);

So, the asm-prototypes.h approach is just the same, only that we now
have a bunch of prototypes in a header file, and the EXPORT_SYMBOL()s
in the assembly files.

As the C prototypes are remote from the definitions, it means that
the C prototypes are going to get forgotten about in exactly the same
way that armksyms.c would've been forgotten about too.

It _is_ worse than that though - with the armksyms.c approach, if the
assembly code for it is removed, you get a build error reminding you
to remove the export (and prototype).  With this approach, you get no
reminder to touch asm-prototypes.h.

It's also error prone for another reason - adding a new assembly level
export, if you forget to add it to asm-prototypes.h, we're back into
the problem we have right now with MODVERSIONS breaking.

So, I still think the whole approach is wrong - it's added extra
fragility that wasn't there with the armksyms.c approach.

-- =

RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
