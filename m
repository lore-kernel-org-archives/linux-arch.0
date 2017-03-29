From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Wed, 29 Mar 2017 13:08:12 -0700
Message-ID: <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------6E417BE794A9F83BFFF076A4"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329055706.GH29622@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <deller@gmx.de>, Martin
List-Id: linux-arch.vger.kernel.org

--------------6E417BE794A9F83BFFF076A4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 03/28/2017 10:57 PM, Al Viro wrote:
> 	We have several primitives for bulk kernel<->userland copying.
> That stuff lives in various asm/uaccess.h, with serious code duplication
> _and_ seriously inconsistent semantics.
>
> 	That code has grown a lot of cruft and more than a few bugs.
> Some got caught and fixed last year, but some fairly unpleasant ones
> still remain.  A large part of problem was that a lot of code used to
> include <asm/uaccess.h> directly, so we had no single place to work
> with.  That got finally fixed in 4.10-rc1, when everything had been
> forcibly switched to including <linux/uaccess.h>.  At that point it
> became possible to start getting rid of boilerplate; I hoped to deal
> with that by 4.11-rc1, but the things didn't work out and that work
> has slipped to this cycle.
>
> 	The patchset currently in vfs.git#work.uaccess is the result;
> there's more work to do, but it takes care of a large part of the
> problems.  About 2.8KLoc removed, a lot of cruft is gone and semantics
> is hopefully in sync now.  All but two architectures (ia64 and metag)
> had been switched to new mechanism; for these two I'm afraid that I'll
> need serious help from maintainers.
>
> 	Currently we have 8 primitives - 6 on every architecture and 2 more
> on biarch ones.  All of them have the same calling conventions: arguments
> are the same as for memcpy() (void *to, const void *from, unsigned long size)
> and the same rules for return value.
> 	If all loads and stores succeed, everything is obvious - the
> 'size' bytes starting at 'to' become equal to 'size' bytes starting at 'from'
> and zero is returned.  If some loads or stores fail, non-zero value should
> be returned.  If any of those primitives returns a positive value N,
> 	* N should be no greater than size
> 	* the values fetched out of from[0..size-N-1] should be stored into the
> corresponding bytes of to[0..size-N-1]
> 	* N should not be equal to size unless not a single byte could have
> been fetched or stored.  As long as that restriction is satisfied, these
> primitives are not required to squeeze every possible byte in case some
> loads or stores fail.
>
> 	1) copy_from_user() - 'to' points to kernel memory, 'from' is
> normally a userland pointer.  This is used for copying structures from
> userland in all kinds of ioctls, etc.  No faults on access to destination are
> allowed, faults on access to source lead to zero-padding the rest of
> destination.  Note that for architectures with the same address space split
> between the kernel and userland (i.e. the ones that have non-trivial
> access_ok()) passing a kernel address instead of a userland one should be
> treated as 'every access would fail'.  In such cases the entire destination
> should be zeroed (failure to do so was a fairly common bug).
> 	Note that all these functions, including copy_from_user(), are
> affected by set_fs() - when called under set_fs(KERNEL_DS), they expect
> kernel pointers where normally a userland one would be given.
>
> 	2) copy_to_user() - 'from' points to kernel memory, 'to' is
> a userland pointer (subject to set_fs() effects, as usual).  Again.
> this is used by all kinds of code in all kinds of drivers, syscalls, etc.
> No faults on access to source, fault on access to destination terminates
> copying.  No zero-padding, of course - the faults are going to be on store
> here.  Does not assume that access_ok() had been checked by caller;
> given 'to'/'size' that fails access_ok() returns "nothing copied".
>
> 	3) copy_in_user() - both 'from' and 'to' are in userland.  Used
> only by compat code that needs to repack 32bit data structures into native
> 64bit counterparts.  As the result, provided only by biarch architectures.
> Subject to set_fs(), but really should not be (and AFAICS isn't) used that way.
> Some architectures tried to zero-pad, but did it inconsistently and it's
> pointless anyway - destination is in userland memory, so no infoleaks would
> happen.
>
> 	4) __copy_from_user_inatomic() - similar to copy_from_user(),
> except that
> 	* the caller is presumed to have verified that the source range passes
> access_ok() [note that this is does not guarantee the lack of faults]
> 	* most importantly, zero-padding SHOULD NOT happen on short copy.
> If implementation fails to guarantee that, it's a bug and potentially
> bad one[1].
> 	* it may be called with pagefaults disabled (of course, in
> that case any pagefault results in a short copy).  That's what 'inatomic'
> in the name refers to.  Note that actually disabling pagefaults is
> up to the caller; blindly calling it e.g. from under a spinlock will just
> get you a deadlock.  Even more precautions are needed to call it from
> something like an interrupt handler - you must do that under set_fs(),
> etc.   It's not "this variant is safe to call from atomic contexts", it's
> "I know what I'm doing, don't worry if you see it in an atomic context".
>
> 	5) __copy_to_user_inatomic().  A counterpart of
> __copy_from_user_inatomic(), except for the direction of copying.
>
> 	6) __copy_from_user().  Essentially the only difference from
> __copy_from_user_inatomic() is that one isn't supposed to call it from
> atomic contexts.  It may be marginally faster than copy_from_user() (due
> to skipped access_ok()), but these days the main costs are not in doing
> fairly light arithmetics.  In theory, you might do a single access_ok()
> covering a large structure and then proceed to call __copy_from_user()
> on various parts of that.  In practice doing many calls of that thing on
> small chunks of data is going to cost a lot on current x86 boxen due to
> STAC/CLAC pair inside each call.  Has fewer call sites than copy_from_user()
> - copy_from_user() is in thousands, while this one has only 40 callers
> outside of arch/, some fairly dubious.  In arch there's about 170 callers
> total, mostly in sigreturn instances.
>
> 	7) __copy_to_user().  A counterpart of __copy_from_user(), with
> pretty much the same considerations applied.
>
> 	8) __copy_in_user().  Basically, copy_in_user() sans access_ok().
> Biarch-only, with the grand total of 6 callers...
>
>
> 	What this series does is:
>
> * convert architectures to fewer primitives (raw_copy_{to,from,in}_user(),
> the last one only on biarch ones), switching to generic implementations
> of the 8 primitives aboves via raw_... ones.  Those generic implementations
> are in linux/uaccess.h (and lib/usercopy.c).  Architecture provides
> raw_... ones, selects ARCH_HAS_RAW_COPY_USER and it's done.
>
> * all object size check, kasan, etc. instrumentation is taken care of
> in linux/uaccess.h; no need to touch it in arch/*
>
> * consistent semantics wrt zero-padding - none of the raw_... do any of
> that, copy_from_user() does (outside of fast path).
>
> At the moment I have that conversion done for everything except ia64 and
> metag.  Once everything is converted, I'll remove ARCH_HAS_RAW_COPY_USER
> and make generic stuff unconditional; at the same point
> HAVE_ARCH_HARDENED_USERCOPY will be gone (becoming unconditionally true).
>
> The series lives in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
> in #work.uaccess.  It's based at 4.11-rc1.  Infrastructure is in
> #uaccess.stem, then it splits into per-architecture branches (uaccess.<arch>),
> eventually merged into #work.uaccess.  Some stuff (including a cherry-picked
> mips build fix) is in #uaccess.misc, also merged into the final.
>
> I hope that infrastructure part is stable enough to put it into never-rebased
> state.  Some of per-architecture branches might be even done right; however,
> most of them got no testing whatsoever, so any help with testing (as well
> as "Al, for fuck sake, dump that garbage of yours, here's the correct patch"
> from maintainers) would be very welcome.  So would the review, of course.
>
> In particular, the fix in uaccess.parisc should be replaced with the stuff
> Helge posted on parisc list, probably along with the get_user/put_user
> patches.  I've put my variant of fix there as a stopgap; switch of pa_memcpy()
> to assembler is clearly the right way to solve it and I'll be happy to
> switch to that as soon as parisc folks settle on the final version of that
> stuff.
>
> For most of the oddball architectures I have no way to test that stuff, so
> please treat the asm-affecting patches in there as a starting point for
> doing it right.  Some might even work as is - stranger things had happened,
> but don't count ont it.
>
> And again, metag and ia64 parts are simply not there - both architectures
> zero-pad in __copy_from_user_inatomic() and that really needs fixing.
> In case of metag there's __copy_to_user() breakage as well, AFAICS, and
> I've been unable to find any documentation describing the architecture
> wrt exceptions, and that part is apparently fairly weird.  In case of
> ia64...  I can test mckinley side of things, but not the generic __copy_user()
> and ia64 is about as weird as it gets.  With no reliable emulator, at that...
> So these two are up to respective maintainers.
>
> Other things not there:
> 	* unification of strncpy_from_user() and friends.  Probably next
> cycle.
> 	* anything to do with uaccess_begin/unsafe accesses/uaccess_end
> stuff.  Definitely next cycle.
>
> I'm not sure if mailbombing linux-arch would be a good idea; there are
> 90 patches in that pile, with total size nearly half a megabyte.  If anyone
> wants that posted, I'll do so, but it might be more convenient to just
> use git.
>
> Comments, review, testing, replacement patches, etc. are very welcome.
>
> 				Al "hates assembers, dozens of them" Viro

Hi Al,

Thx for taking this up. It seems ARC was missing INLINE_COPY* switch likely due to
existing 2 variants (inline/out-of-line) we already have.
I've added a patch for that (attached too) - boot tested the series on ARC.

------->
From 29205ba126468986fcee0d12dba6b5f831506803 Mon Sep 17 00:00:00 2001
From: Vineet Gupta <vgupta@synopsys.com>
Date: Wed, 29 Mar 2017 11:53:33 -0700
Subject: [PATCH] ARC: uaccess: enable INLINE_COPY_{TO,FROM}_USER ...

... and switch to generic out of line version in lib/usercopy.c

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/uaccess.h | 16 ++++++----------
 arch/arc/mm/extable.c          | 14 --------------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index c4d26e8a21b3..f35974ee7264 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -168,7 +168,7 @@
 
 
 static inline unsigned long
-__arc_copy_from_user(void *to, const void __user *from, unsigned long n)
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
     long res = 0;
     char val;
@@ -395,7 +395,7 @@ __arc_copy_from_user(void *to, const void __user *from,
unsigned long n)
 }
 
 static inline unsigned long
-__arc_copy_to_user(void __user *to, const void *from, unsigned long n)
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
     long res = 0;
     char val;
@@ -721,24 +721,20 @@ static inline long __arc_strnlen_user(const char __user *s,
long n)
 }
 
 #ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
-#define raw_copy_from_user        __arc_copy_from_user
-#define raw_copy_to_user        __arc_copy_to_user
+
+#define INLINE_COPY_TO_USER
+#define INLINE_COPY_FROM_USER
+
 #define __clear_user(d, n)        __arc_clear_user(d, n)
 #define __strncpy_from_user(d, s, n)    __arc_strncpy_from_user(d, s, n)
 #define __strnlen_user(s, n)        __arc_strnlen_user(s, n)
 #else
-extern long arc_copy_from_user_noinline(void *to, const void __user * from,
-        unsigned long n);
-extern long arc_copy_to_user_noinline(void __user *to, const void *from,
-        unsigned long n);
 extern unsigned long arc_clear_user_noinline(void __user *to,
         unsigned long n);
 extern long arc_strncpy_from_user_noinline (char *dst, const char __user *src,
         long count);
 extern long arc_strnlen_user_noinline(const char __user *src, long n);
 
-#define raw_copy_from_user        arc_copy_from_user_noinline
-#define raw_copy_to_user        arc_copy_to_user_noinline
 #define __clear_user(d, n)        arc_clear_user_noinline(d, n)
 #define __strncpy_from_user(d, s, n)    arc_strncpy_from_user_noinline(d, s, n)
 #define __strnlen_user(s, n)        arc_strnlen_user_noinline(s, n)
diff --git a/arch/arc/mm/extable.c b/arch/arc/mm/extable.c
index c86906b41bfe..72125a34e780 100644
--- a/arch/arc/mm/extable.c
+++ b/arch/arc/mm/extable.c
@@ -28,20 +28,6 @@ int fixup_exception(struct pt_regs *regs)
 
 #ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 
-long arc_copy_from_user_noinline(void *to, const void __user *from,
-        unsigned long n)
-{
-    return __arc_copy_from_user(to, from, n);
-}
-EXPORT_SYMBOL(arc_copy_from_user_noinline);
-
-long arc_copy_to_user_noinline(void __user *to, const void *from,
-        unsigned long n)
-{
-    return __arc_copy_to_user(to, from, n);
-}
-EXPORT_SYMBOL(arc_copy_to_user_noinline);
-
 unsigned long arc_clear_user_noinline(void __user *to,
         unsigned long n)
 {
-- 
2.7.4

--------------6E417BE794A9F83BFFF076A4
Content-Type: text/x-patch;
	name="0001-ARC-uaccess-enable-INLINE_COPY_-TO-FROM-_USER.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-ARC-uaccess-enable-INLINE_COPY_-TO-FROM-_USER.patch"

From 29205ba126468986fcee0d12dba6b5f831506803 Mon Sep 17 00:00:00 2001
From: Vineet Gupta <vgupta@synopsys.com>
Date: Wed, 29 Mar 2017 11:53:33 -0700
Subject: [PATCH] ARC: uaccess: enable INLINE_COPY_{TO,FROM}_USER ...

... and switch to generic out of line version in lib/usercopy.c

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/uaccess.h | 16 ++++++----------
 arch/arc/mm/extable.c          | 14 --------------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index c4d26e8a21b3..f35974ee7264 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -168,7 +168,7 @@
 
 
 static inline unsigned long
-__arc_copy_from_user(void *to, const void __user *from, unsigned long n)
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	long res = 0;
 	char val;
@@ -395,7 +395,7 @@ __arc_copy_from_user(void *to, const void __user *from, unsigned long n)
 }
 
 static inline unsigned long
-__arc_copy_to_user(void __user *to, const void *from, unsigned long n)
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	long res = 0;
 	char val;
@@ -721,24 +721,20 @@ static inline long __arc_strnlen_user(const char __user *s, long n)
 }
 
 #ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
-#define raw_copy_from_user		__arc_copy_from_user
-#define raw_copy_to_user		__arc_copy_to_user
+
+#define INLINE_COPY_TO_USER
+#define INLINE_COPY_FROM_USER
+
 #define __clear_user(d, n)		__arc_clear_user(d, n)
 #define __strncpy_from_user(d, s, n)	__arc_strncpy_from_user(d, s, n)
 #define __strnlen_user(s, n)		__arc_strnlen_user(s, n)
 #else
-extern long arc_copy_from_user_noinline(void *to, const void __user * from,
-		unsigned long n);
-extern long arc_copy_to_user_noinline(void __user *to, const void *from,
-		unsigned long n);
 extern unsigned long arc_clear_user_noinline(void __user *to,
 		unsigned long n);
 extern long arc_strncpy_from_user_noinline (char *dst, const char __user *src,
 		long count);
 extern long arc_strnlen_user_noinline(const char __user *src, long n);
 
-#define raw_copy_from_user		arc_copy_from_user_noinline
-#define raw_copy_to_user		arc_copy_to_user_noinline
 #define __clear_user(d, n)		arc_clear_user_noinline(d, n)
 #define __strncpy_from_user(d, s, n)	arc_strncpy_from_user_noinline(d, s, n)
 #define __strnlen_user(s, n)		arc_strnlen_user_noinline(s, n)
diff --git a/arch/arc/mm/extable.c b/arch/arc/mm/extable.c
index c86906b41bfe..72125a34e780 100644
--- a/arch/arc/mm/extable.c
+++ b/arch/arc/mm/extable.c
@@ -28,20 +28,6 @@ int fixup_exception(struct pt_regs *regs)
 
 #ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 
-long arc_copy_from_user_noinline(void *to, const void __user *from,
-		unsigned long n)
-{
-	return __arc_copy_from_user(to, from, n);
-}
-EXPORT_SYMBOL(arc_copy_from_user_noinline);
-
-long arc_copy_to_user_noinline(void __user *to, const void *from,
-		unsigned long n)
-{
-	return __arc_copy_to_user(to, from, n);
-}
-EXPORT_SYMBOL(arc_copy_to_user_noinline);
-
 unsigned long arc_clear_user_noinline(void __user *to,
 		unsigned long n)
 {
-- 
2.7.4


--------------6E417BE794A9F83BFFF076A4--
