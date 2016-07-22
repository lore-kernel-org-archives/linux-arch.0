Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34240 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbcGVVtz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Jul 2016 17:49:55 -0400
Date: Fri, 22 Jul 2016 16:49:45 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC v3 10/13] jump_label: port __jump_table to linker tables
Message-ID: <20160722214945.h7v7fvsnuhnvz6ux@treble>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
 <1469222687-1600-11-git-send-email-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1469222687-1600-11-git-send-email-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, ciaran.farrell@suse.com, christopher.denicolo@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org
Message-ID: <20160722214945.r-COcuswBP65uHDsq5ABKrFp-65HKp2Qy9iUuewST_8@z>

On Fri, Jul 22, 2016 at 02:24:44PM -0700, Luis R. Rodriguez wrote:
> diff --git a/tools/objtool/special.c b/tools/objtool/special.c
> index bff8abb3a4aa..f0ad369f994b 100644
> --- a/tools/objtool/special.c
> +++ b/tools/objtool/special.c
> @@ -26,6 +26,10 @@
>  #include "special.h"
>  #include "warn.h"
>  
> +#include "../../include/asm-generic/sections.h"
> +#include "../../include/asm-generic/tables.h"
> +#include "../../include/linux/stringify.h"
> +
>  #define EX_ENTRY_SIZE		12
>  #define EX_ORIG_OFFSET		0
>  #define EX_NEW_OFFSET		4
> @@ -63,7 +67,9 @@ struct special_entry entries[] = {
>  		.feature = ALT_FEATURE_OFFSET,
>  	},
>  	{
> -		.sec = "__jump_table",
> +		.sec = __stringify(SECTION_TBL(SECTION_DATA,
> +				               __jump_table,
> +					       SECTION_ORDER_ANY)),
>  		.jump_or_nop = true,
>  		.size = JUMP_ENTRY_SIZE,
>  		.orig = JUMP_ORIG_OFFSET,

(continuing our discussion from another thread...)

I think tools code isn't allowed to include kernel files because the
tools subdirectory is supposed to be completely independent.
 
As far as I can tell, the section name will always be
".data.tbl.__jump_table.any".  Is that true?  If so, any reason why we
can't just hard-code the string here?  As you saw, if the string
changes, objtool will complain and 0-day will report it.

-- 
Josh
