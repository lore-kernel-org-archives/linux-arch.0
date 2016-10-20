From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Fri, 21 Oct 2016 01:20:17 +1100
Message-ID: <20161021012017.67b75a90@roar.ozlabs.ibm.com>
References: <20161017065131.GA27863@angband.pl>
        <6556201.qTG4Pa4aHk@wuerfel>
        <fafba13a-c64c-2578-534c-c344f18d0fc5@suse.com>
        <3114442.xCAy34UQCk@wuerfel>
        <20161019153159.GQ1041@n2100.armlinux.org.uk>
        <20161020150814.42951f61@roar.ozlabs.ibm.com>
        <20161020131702.GX1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161020131702.GX1041@n2100.armlinux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 20 Oct 2016 14:17:02 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Thu, Oct 20, 2016 at 03:08:14PM +1100, Nicholas Piggin wrote:
> > Fair point, what about leaving those as they are, and also adding
> > them to asm-prototypes.h protected with GENKSYMS ifdef? It's not
> > beautiful, but still better than armksyms.c before Al's patches (or
> > at least no worse).  
> 
> I disagree (also see below).  The armksyms way was understandable.
> The new way... I've no idea yet, because I wasn't even copied on

New way is you put the EXPORT_SYMBOL in the .S file, and give it a C
style prototype in asm-prototypes.h, and that's it. The build system
will do the rest. Either way you require some file of C prototypes,
but after Al's patches, at least the EXPORT goes with its definition.

As far as rebuilding too often, that sounds like a bug, more below.


> any of the patches.  I've no idea how the exports are now handled.
> I'm in a black hole with respect to that, and that's now a problem.
> 
> > > Now, it would have _ALSO_ been nice to have been at least COPIED on the
> > > original set of changes that caused the need for this change.  I wasn't.
> > > So I want to see the original set of changes reverted, because they're
> > > clearly causing breakage.  Let's revert them and then go through the
> > > proper process of maintainer review, rather than bypassing maintainers
> > > and screwing up architectures in the process.  There really is no
> > > excuse for this crap.  
> > 
> > You may have a point about improvement of the process. I wasn't
> > involved in the original patches, but we did cc linux-arch when the
> > .S CRC issue became known.  
> 
> Yes, but I'm not on linux-kernel-v2, and I've no desire to end up with
> another list I've no hope of keeping up with to my mailbox - I'll just
> ignore it.  99% of the messages on it at the time when vger kicked me
> off the list was x86 related discussion, and not really cross-arch
> issues.  As I say, it just became another linux-kernel list.

For the patches that touched arm code, I'd agree you should have been cc'ed.

Not to dismiss that concern at all, but for issues of interest to arch code
but not specific to any (such as discovery that the asm exports change would
require this change to restore CRC generation), I was just saying linux-arch
is most appropriate for better or worse. Ccing 30 arch lists is not workable.

And again not to dismiss your concern, I'm just here trying to come up with
a workable fix for the non-revert scenario. Revert is no less valid an
option, it's just not one I'm in favour of myself.


> > However let's work on the assumption that they won't be reverted at this
> > stage, and try to come up with something to fix it that you're happy with.  
> 
> Well, there's more problems with this new KSYMS approach than just the
> CRCs.  It forces a rebuild of the ksyms files every single time, which
> then causes a relink of the kernel:

Good catch, I'm surprised you're the first one who reported it. This patch
seems to do the trick for me:

From: Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 21 Oct 2016 01:13:33 +1100
Subject: [PATCH] kbuild: prevent lib-ksyms.o rebuilds

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

---
 scripts/Makefile.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index de46ab0..e1f25d6 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -430,6 +430,9 @@ cmd_export_list = $(OBJDUMP) -h $< | \
 
 $(obj)/lib-ksyms.o: $(lib-target) FORCE
 	$(call if_changed,export_list)
+
+targets += $(obj)/lib-ksyms.o
+
 endif
 
 #
-- 
2.9.3

