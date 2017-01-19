Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdASLd5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2017 06:33:57 -0500
Date: Thu, 19 Jan 2017 12:24:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 09/14] jump_label: port __jump_table to linker tables
Message-ID: <20170119112411.GN28024@kroah.com>
References: <20170109145833.11502-1-mcgrof@kernel.org>
 <20170115211057.17167-1-mcgrof@kernel.org>
 <20170115211057.17167-10-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170115211057.17167-10-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: bp@alien8.de, bp@suse.de, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, adrian.hunter@intel.com, dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com, dmitry.torokhov@gmail.com, joro@8bytes.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20170119112411.4UIPwcoF9nKyCVj9fLur_5SJimKp8ujTXXc3H0VUxqo@z>

On Sun, Jan 15, 2017 at 01:10:52PM -0800, Luis R. Rodriguez wrote:
> Move the __jump_table from the a custom section solution
> to a generic solution, this avoiding extra vmlinux.lds.h
> customizations.
> 
> This also demos the use of the .data linker table and of
> the shared asm call push_section_tbl().
> 
> Built-in kernel functionality was tested with CONFIG_STATIC_KEYS_SELFTEST.
> Moduler  kernel functionality was tested with CONFIG_TEST_STATIC_KEYS.
> Both work as expected.
> 
> Since __jump_table sections are also supported per
> module this also required expanding module-common.lds.S
> to capture and fold all .data.tlb.__jump_table.* onto
> the the section __jump_table -- in this case for modules
> need to keep a reference in place, given the alternative
> is to use DEFINE_LINKTABLE(struct jump_entry, __jump_table)
> per module -- and later through macro hacks instantiate
> the jump entries per module upon init. This is doable but
> we'd loose out on the sorting of the table using the
> linker, to sort we'd always still need to expand the
> module common linker script. An alternative mechanism
> is possible which would make these custom module sections
> extensions dynamic without requiring manual changes, this
> however is best done later through a separate evolution
> once linker tables are in place.
> 
> A careful reviewer may note that some architectures use
> "\n\t" to separate asm code, while others just use a new line.
> Upon review last time it was deemed reasonable to for all
> architectures to just use "\n", this is defined as ASM_CMD_SEP,
> and if an architecture needs to override they can do so on their
> architecture sections.h prior to including asm-generic/sections.h
> 
> v6: rename table macro as suggested by Andy Shevchenko
> 
> v5:
> 
> o Use ..tbl instead of .tbl as suggested by Nicholas Piggin.
>   This is the typical way to avoid clash with compiler generated
>   section.
> 
> o Replace section macros with section names
> 
> o Use LINKTABLE_START() and LINKTABLE_END()
> 
> o fixed tile jump label port -- tile got jump label support as of
>   commit 65a792e84f25d1 ("tile/jump_label: add jump label support
>   for TILE-Gx"), as such we just needed to adjust the asm to account
>   for the new linker table API use. This commit was merged as of v4.5-rc1.
> 
> v4:
> 
> o Some architectures allow linker scripts to follow including header
>   files, some others do not, so if you need a helper on a linker script
>   you need to explicitly include it. So for instance although
>   scripts/module-common.lds.S includes <asm/tables.h> and this file
>   includes <asm/section-core.h>, you still need to explicitly
>   include it on the linker script. This issue is present on ARM.
> 
> o as per Josh Poimboeuf open code the section table name instead
>   of including the kernel section headers, the simplicity and
>   independence from the kernel is preferred.
> 
> v3:
> 
> o More elaborate tests performed
> o first modular support use case, module tested was
>   CONFIG_TEST_STATIC_KEYS (lib/test_static_keys.ko), this
>   required us to extend module-common.lds.S
> o use generic push_section_tbl_any() for all architectures
> o Makes use of ASM_CMD_SEP to enable architectures to override later
>   if needed
> o guard tables.h inclusion and table definition with __KERNEL__
> 
> v2: introduced in this series
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  arch/arm/include/asm/jump_label.h     |  6 ++++--
>  arch/arm64/include/asm/jump_label.h   |  6 ++++--
>  arch/mips/include/asm/jump_label.h    |  6 ++++--
>  arch/powerpc/include/asm/jump_label.h |  8 +++++---
>  arch/s390/include/asm/jump_label.h    |  6 ++++--
>  arch/sparc/include/asm/jump_label.h   |  6 ++++--
>  arch/tile/include/asm/jump_label.h    |  5 +++--
>  arch/x86/include/asm/jump_label.h     | 10 ++++++----
>  include/asm-generic/vmlinux.lds.h     |  5 -----
>  include/linux/jump_label.h            |  4 ++--
>  kernel/jump_label.c                   | 17 ++++++++++-------
>  scripts/module-common.lds             |  1 +
>  tools/objtool/special.c               |  2 +-
>  13 files changed, 48 insertions(+), 34 deletions(-)

meta-comment.  This new infrastructure doesn't seem to save any code
when you need to have a new "link table".  Yes, the macros seem a bit
nicer, but it feels like unneeded churn.  I haven't seen any patches in
this series that makes me go "oh yeah, now I see why he did this work,
it's so much simpler and easy to understand now!"

What am I missing?  What wonderful new things are going to happen, or
where is the code savings going to come from with this series to justify
all of the work to create and review this?

thanks,

greg k-h
