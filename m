Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761524AbdACWD6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Jan 2017 17:03:58 -0500
Date: Tue, 3 Jan 2017 22:27:44 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 09/14] jump_label: port __jump_table to linker tables
Message-ID: <20170103212744.GF13946@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <20161222023811.21246-1-mcgrof@kernel.org>
 <20161222023811.21246-10-mcgrof@kernel.org>
 <1482415702.9552.125.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1482415702.9552.125.camel@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, adrian.hunter@intel.com, dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com, dmitry.torokhov@gmail.com, joro@8bytes.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20170103212744.e3gN6UoX1juV2utjPN1UBHaMNGSjLmLUszK-UGUAbeE@z>

On Thu, Dec 22, 2016 at 04:08:22PM +0200, Andy Shevchenko wrote:
> On Wed, 2016-12-21 at 18:38 -0800, Luis R. Rodriguez wrote:
> > Move the __jump_table from the a custom section solution
> > to a generic solution, this avoiding extra vmlinux.lds.h
> > customizations.
> > 
> > This also demos the use of the .data linker table and of
> > the shared asm call push_section_tbl().
> > 
> 
> >  {
> >  	asm_volatile_goto("1:\n\t"
> >  		 WASM(nop) "\n\t"
> > -		 ".pushsection __jump_table,  \"aw\"\n\t"
> > +		 push_section_tbl_any(.data, __jump_table, aw)
> >  		 ".word 1b, %l[l_yes], %c0\n\t"
> >  		 ".popsection\n\t"
> >  		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
> > @@ -26,7 +28,7 @@ static __always_inline bool
> > arch_static_branch_jump(struct static_key *key, bool
> >  {
> >  	asm_volatile_goto("1:\n\t"
> >  		 WASM(b) " %l[l_yes]\n\t"
> > -		 ".pushsection __jump_table,  \"aw\"\n\t"
> > +		 push_section_tbl_any(.data, __jump_table, aw)
> >  		 ".word 1b, %l[l_yes], %c0\n\t"
> >  		 ".popsection\n\t"
> 
> Does it make sense to introduce something like
> 
> #define pop_section_tbl ".popsection\n\t"
> #define pop_section_tbl_any pop_section_tbl

Absolutely ! However this would be an evolution, and I would much
prefer to add this later as an atomic step later to enable other
users to also be using this shared macro. I did not have an immediate
need for a pop_section_tbl() macro as its not section specific.

  Luis
