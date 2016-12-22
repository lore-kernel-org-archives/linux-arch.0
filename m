Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:47257 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754679AbcLVOLs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Dec 2016 09:11:48 -0500
Message-ID: <1482415702.9552.125.camel@linux.intel.com>
Subject: Re: [PATCH v5 09/14] jump_label: port __jump_table to linker tables
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 22 Dec 2016 16:08:22 +0200
In-Reply-To: <20161222023811.21246-10-mcgrof@kernel.org>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
         <20161222023811.21246-1-mcgrof@kernel.org>
         <20161222023811.21246-10-mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, adrian.hunter@intel.com, dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com, dmitry.torokhov@gmail.com, joro@8bytes.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20161222140822.R3e-aBtaVpNas203SBcHTuFiJ3WwI4-GD1k6cw1TnAQ@z>

On Wed, 2016-12-21 at 18:38 -0800, Luis R. Rodriguez wrote:
> Move the __jump_table from the a custom section solution
> to a generic solution, this avoiding extra vmlinux.lds.h
> customizations.
> 
> This also demos the use of the .data linker table and of
> the shared asm call push_section_tbl().
> 

>  {
>  	asm_volatile_goto("1:\n\t"
>  		 WASM(nop) "\n\t"
> -		 ".pushsection __jump_table,  \"aw\"\n\t"
> +		 push_section_tbl_any(.data, __jump_table, aw)
>  		 ".word 1b, %l[l_yes], %c0\n\t"
>  		 ".popsection\n\t"
>  		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
> @@ -26,7 +28,7 @@ static __always_inline bool
> arch_static_branch_jump(struct static_key *key, bool
>  {
>  	asm_volatile_goto("1:\n\t"
>  		 WASM(b) " %l[l_yes]\n\t"
> -		 ".pushsection __jump_table,  \"aw\"\n\t"
> +		 push_section_tbl_any(.data, __jump_table, aw)
>  		 ".word 1b, %l[l_yes], %c0\n\t"
>  		 ".popsection\n\t"

Does it make sense to introduce something like

#define pop_section_tbl ".popsection\n\t"
#define pop_section_tbl_any pop_section_tbl

?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
