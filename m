Return-Path: <pj@sgi.com>
Received: from mtvcafw.sgi.com ([192.48.171.6]:26190 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263861AbUDVHlC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 03:41:02 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id i3M7lGEa026253
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2004 00:47:16 -0700
Received: from sam.engr.sgi.com (sam.engr.sgi.com [163.154.6.103])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id i3M7eZAW5248168
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2004 00:41:00 -0700 (PDT)
Date: Thu, 22 Apr 2004 00:40:35 -0700
From: Paul Jackson <pj@sgi.com>
Subject: Review requested - bitmap/cpumask rework
Message-Id: <20040422004035.379940d6.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Bill Irwin recommended that I contact the various arch maintainers
via this email list with the following ...

I am proposing a round of rework and cleanup of the cpumask code in the
kernel, to reduce the number of various implementation flavors and
simplify it some.  This proposal should also enable Matthew Dobson to
follow along behind me with a patch adding a nodemask_t, very similar to
a cpumask_t, with a minimum of additional kernel code.

I have done my reasonable best to see that this patch generates just as
good code as before, but I am really only testing the SN2 variant of the
ia64 arch.

One key issue, noted by Bill Irwin, is (in his words, I hope he doesn't
mind my quoting him here ...):

    The issues here relevant to arches is essentially whether
    the constructs you're using in the mask.h/etc. headers
    work on the toolchain versions the various arches require,
    and whether the compiler versions they require generate
    acceptably efficient code (which unfortunately has no
    objective definition). This is an issue because it has been
    observed to break even i386 on some toolchain versions,
    and to generate inefficient code on others.

I could have easily broken, or harmed the performance of, some
other arch.

Patches 9, 10, 11, 13, 14, and 16 in particular (described below) are
specific to various arch's including i386, ppc64, x86_64, and sparc64.

Could you please consider the following for the arch(s) you have
interest in, and let me know, one way or the other, if you have
suggestions or questions or see problems.

I have just posted this patch set to lkml, in the form of an overview
message:

  [Patch 0 of 17] cpumask v4 - bitmap and cpumask cleanup

and 17 followup messages, one patch each.

Here is the overview message.  Note especially the section called "Risks".

Thank-you for your consideration.

===================================== snip =====================================
	  	Bitmap and Cpumask Cleanup

This is the fourth version of my cleanup of cpumasks.

This set of 17 patches applies against a vanilla 2.6.5 kernel.

The actual patches will be posted in another hour or two, as
followups to this initial post.

Primay goals:
  The primary goal of this patch set is to simplify the code for
  cpumask_t and (later) nodemask_t, make them easier to use, and
  reduce code duplication.

  Several flavors of cpumask have been reduced to one, with some
  local special handling to optimize for that vast majority of
  systems which have less than 32 CPUs.
  
  The bitmap operations upon which cpumasks depend have been
  optimized a bit more, with a more careful mix of inline and
  outofline code.

  By simplifying masks to a single file, it should also be
  easier to add other such mask types, such as the nodemask
  that Matthew Dobson has waiting in the wings, just by
  copying cpumask.h and making a few global edits.

Compared to the third version (8 April) of this patch set:
  1) Doesn't include Matthew Dobson's nodemask patch.
     Matthew will submit that patch separately, after
     the fate of this cleanup patch is resolved.
  2) Has one typo fixed in a comment.

What's next:
  I will seek out the feedback of the architecture maintainers
  over the next few days to this patch, and continue local
  testing.  Then it should be ready to submit to Andrew.

What's new (comparing 2.6.5 to this patch set):
  1) Some 27 files matching the pattern include/*/*mask*.h
     are replaced with the single file include/linux/cpumask.h
     The variety of arch-specific redirect headers for various
     cpumask implementation flavors is gone.
  2) The bitmap operations (bitmap.h, bitmap.c) are optimized
     for systems of less than 32 CPUs.
  3) The cpumask operations are now just a thin layer on top
     of the bitmask and a few other operations.  A cpumask is a
     bitmask of exactly NR_CPUS bits, wrapped in a structure.
  4) bitmap_complement and cpumask_complement now take two args,
     source and target, instead of working in place.
  5) Some uses of these macros elsewhere in the kernel were fine
     tuned.
  6) On ia64, find_first_bit and find_first_zero_bit are
     uninlined - saving quite a bit of kernel text space.
     The architectures: alpha, parisc, ppc, sh, sparc, sparc64
     have this same bit find code, and might also want to uninline. 
  7) Comments in bitmap.h and cpumask.h list available ops for ease
     of browsing.
  8) The MASK_ALL macro zeros out unused bits on multiword bitmaps.
  9) This patch includes Bill Irwin's very recent rewrite
     of the bitmap_shift operators to avoid assuming some
     fixed upper bound on bitmap sizes.
 10) A few more mask macros have been added, to make it easier to
     code mask manipulations correctly and easily.  They provide
     xor, andnot, intersects and subset operators.

Bug fixes:
  1) *_complement macros don't leave unused high bits set
  2) MASK_ALL for sizes > 1 word, but not exact word multiple,
     doesn't have unused high bits set
  3) Explicit, documented semantics for handling these unused high bits.
  4) A few missing const attributes in bitmap & bitops added.
  5) The (Hamming) cpumask weight macros were using the bitops hweight*()
     macros, which don't mask high unused bits - fixed to use the bitmap
     weight macro which does this masking.

  Do to the rather limited use so far of cpumask macros, I am
  not aware of anything that these bugs would actually break in
  current mm or linus kernels.

Testing so far:
  Kernels have been built for i386 and ia64, and booted and
  minimally tested for ia64.  Kernel text size has been
  compared and found to typically get a little smaller for
  these two arch's.  Correct function of bit operations has
  been tested for a variety of NR_CPUS values in a user level
  framework.  Gcc compiler versions 2.95.3, 3.2.3 and 3.3.2
  have been built successfully.

Risks:
  This patch set makes changes in bitmap and cpumask handling
  code in several architectures.  I could have broken something.

  Other affected arch's, need to be tested and reviewed.
  The other arch's seeing the most changes were i386, ppc64
  and x86_64, but specific changes to alpha, arm, mips, sparc64
  and sh aloo need review.

  This patch set removes several more optimized variants of
  mask, which were targeted for optimum performance on various
  architectures, and replaces that with essentially a single
  variant.  Preliminary analysis on the one architecture I
  cared most about (large ia64) shows no noticeable degradation
  in the quality of the code generated for mask operations,
  but other architectures or more demanding uses may require
  further optimization work.

  This patch set might have dependencies on specific gcc or
  toolchain versions.  Portions have worked with both gcc
  2.95.3 and 3.3.2 inside a user level scaffolding on i386.
  Kernels have been built and booted on ia64 using gcc 3.2.3
  and built on i386 using gcc 3.3.2.  But non-trivial use is
  made of gcc extensions, so certain archs or toolchains might
  not build, or might not produce sufficiently optimal code,
  or might not even work.

  This patch set changes the semantics of cpumasks slightly.
  If all mask operations are performed with correct parameters,
  and no bits are intentionally set outside the range of bits
  covered by such a mask (typically this means outside the
  range [0 ... NR_CPUS-1] for cpumask_t), then there should be
  no noticeable difference.  Code that (improperly) sets bits
  outside that valid range may notice differences in when such
  bits affect the results of other mask operations.

  Patches 13 through 16 (see list of patches, below) in
  particular attempt to "cleanup" some cpumask manipulation
  code in various sparc and intel arch's.  These patches are
  not essential - if they get in the way of other work, or are
  too much distraction, or break something, any of them can
  be dropped.  At a minimum, they require review and approval
  from the affected arch's.


================ Patch Details ================

Here's what each patch does:

[Patch 1 of 17] cpumask v4 - Document bitmap.c bit model.
        Document the bitmap bit model, including handling of unused bits,
        and operation preconditions and postconditions.

[Patch 2 of 17] cpumask v4 - Dont generate nonzero unused bits in bitmap
        Tighten up bitmap so it does not generate nonzero bits
        in the unused tail if it is not given any on input.

[Patch 3 of 17] cpumask v4 - New bitmap operators and two op complement
        Add intersects, subset, xor and andnot operators.
        Change bitmap_complement to take two operands.

[Patch 4 of 17] cpumask v4 - two missing 'const' qualifiers in bitops/bitmap
        Add a couple of missing 'const' qualifiers on
        bitops test_bit and bitmap_equal args.

[Patch 5 of 17] cpumask v4 - Optimize and extend bitmap.

        This bitmap improvements make it a suitable basis for
        fully supporting cpumask_t and nodemask_t.  Inline macros
        with compile-time checks enable generating tight code on
        both small and large systems (large meaning cpumask_t
        requires more than one unsigned long's worth of bits).

        The existing bitmap_<op> macros in lib/bitmap.c
        are renamed to __bitmap_<op>, and wrappers for each
        bitmap_<op> are exposed in include/linux/bitmap.h

	This patch _includes_ Bill Irwins rewrite of the
	bitmap_shift operators to not require a fixed length
	intermediate bitmap.

	Improved comments list each available operator for easy
	browsing.

[Patch 6 of 17] cpumask v4 - Uninline find_next_bit on ia64

	Move the page of code (~700 bytes of instructions)
	for find_next_bit and find_next_zero_bit from inline
	in include/asm-ia64/bitops.h to a real function in
	arch/ia64/lib/bitops.c, leaving a declaration and
	macro wrapper behind.

	The other arch's with almost this same code might want to
	also uninline it: alpha, parisc, ppc, sh, sparc, sparc64.

	These are too big to inline.

[Patch 7 of 17] cpumask v4 - Rewrite cpumask.h to use bitmap directly.

	Major rewrite of cpumask to use a single implementation,
	as a struct-wrapped bitmap.

	This patch leaves some 26 include/asm-*/cpumask*.h
	header files orphaned - to be removed next patch.

	Some nine cpumask macros for const variants and to
	coerce and promote between an unsigned long and a
	cpumask are obsolete.  Simple emulation wrappers are
	provided in this patch, which can be removed once each
	of the 3 archs (i386, ppc64, x86_64) using them are
	recoded in follow-on patches to not need them.

	The CPU_MASK_ALL macro now avoids leaving possible
	garbage one bits in any unused portion of the high word.

	An improved comment lists all available operators, for
	convenient browsing.

[Patch 8 of 17]  cpumask v4 - Remove 26 no longer used cpumask headers.
	With the cpumask rewrite in the previous patch, these
	various include/asm-*/cpumask*.h headers are no longer used.

[Patch 9 of 17] cpumask v4 - Recode obsolete cpumask macros - arch i386
	Remove by recoding all uses of the obsolete cpumask const,
	coerce and promote macros.

[Patch 10 of 17] cpumask v4 - Recode obsolete cpumask macros - arch ppc64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

[Patch 11 of 17] cpumask v4 - Recode obsolete cpumask macros - arch x86_64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

[Patch 12 of 17] cpumask v4 - Remove obsolete emulation from cpumask.h
        Now that the emulation of the obsolete cpumask macros is no
        longer needed, remove it from cpumask.h

[Patch 13 of 17] cpumask v4 - Simplify some sparc64 cpumask loop code
        Make use of for_each_cpu_mask() macro to simplify and optimize
        a couple of sparc64 per-CPU loops.  This code change has _not_
        been tested or reviewed.  Feedback welcome.  There is non-trivial
        risk that I still don't understand the logic here.

[Patch 14 of 17] cpumask v4 - Optimize i386 cpumask macro usage.
        Optimize a bit of cpumask code for asm-i386/mach-es7000
        Code untested, unreviewed.  Feedback welcome.

[Patch 15 of 17] cpumask v4 - Convert physids_complement() to use both args
        Provide for specifying distinct source and dest args to the
        physids_complement().  No one actually uses this macro yet.
        The physid_mask type would be a good candidate to convert to
        using this new mask ADT as a base.

[Patch 16 of 17] cpumask v4 - Remove cpumask hack from asm-x86_64/topology.h
        This file had the cpumask cpu_online_map as type
        unsigned long, instead of type cpumask_t, for no good
        reason that I could see.  So I changed it.  Everywhere
        else, cpu_online_map is already of type cpumask_t.

[Patch 17 of 17] cpumask v4 - Cpumask code clarification in kernel/sched.c
        Clarify and slightly optimize set_cpus_allowed() cpumask check

===================================== snip =====================================
-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
