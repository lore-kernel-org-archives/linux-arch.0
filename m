Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mipsfw.mips-uk.com ([194.74.144.146]:23838 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1750833AbWBBL40 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Feb 2006 06:56:26 -0500
Date: Wed, 1 Feb 2006 13:50:03 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Fw: [PATCH] abstract type/size specification for assembly
Message-ID: <20060201135002.GA6386@linux-mips.org>
References: <20060131143149.35db2e02.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131143149.35db2e02.akpm@osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jan 31, 2006 at 02:31:49PM -0800, Andrew Morton wrote:

> OK?

No.

> diff -puN include/linux/linkage.h~abstract-type-size-specification-for-assembly include/linux/linkage.h
> --- 25/include/linux/linkage.h~abstract-type-size-specification-for-assembly	Tue Jan 31 14:30:58 2006
> +++ 25-akpm/include/linux/linkage.h	Tue Jan 31 14:30:58 2006
> @@ -39,6 +39,11 @@
>    ALIGN; \
>    name:
>  
> +#define ENDPROC(name) \
> +  .type name, @function; \
> +  END(name)
> +#define END(name) \
> +  .size name, .-name
>  
>  #endif

No.  On MIPS we need a .end directive as well; since the dawn of Linux I
have the following in include/asm-mips/asm.h:

#define END(function)                                   \
                .end    function;                       \
                .size   function,.-function

And while we're at it, the ENTRY definition there isn't usable on MIPS
either; we need two different definitions for leaf and no-leaf functions
which again are in asm.h:

/*
 * LEAF - declare leaf routine
 */
#define LEAF(symbol)                                    \
                .globl  symbol;                         \
                .align  2;                              \
                .type   symbol,@function;               \
                .ent    symbol,0;                       \
symbol:         .frame  sp,0,ra

/*
 * NESTED - declare nested routine entry point
 */
#define NESTED(symbol, framesize, rpc)                  \
                .globl  symbol;                         \
                .align  2;                              \
                .type   symbol,@function;               \
                .ent    symbol,0;                       \
symbol:         .frame  sp, framesize, rpc

  Ralf
