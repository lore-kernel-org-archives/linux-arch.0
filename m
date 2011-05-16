From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 3/4] ia64 mcount offset calculation
Date: Mon, 16 May 2011 14:58:21 -0400
Message-ID: <1305572301.5456.24.camel@gandalf.stny.rr.com>
References: <20110510081039.241831019@de.ibm.com>
	 <20110510081103.902546467@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:43205 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab1EPS6a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 May 2011 14:58:30 -0400
In-Reply-To: <20110510081103.902546467@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org

Tony,

Can you give me an Acked-by for this patch?

Thanks,

-- Steve


On Tue, 2011-05-10 at 10:10 +0200, Martin Schwidefsky wrote:
> plain text document attachment (302-mcount-adjust-ia64.diff)
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Do the mcount offset adjustment in the recordmcount.pl/recordmcount.[ch]
> at compile time and not in ftrace_call_adjust at run time.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
> 
>  arch/ia64/include/asm/ftrace.h |    7 +++++--
>  scripts/recordmcount.c         |    7 ++++++-
>  scripts/recordmcount.pl        |    1 +
>  3 files changed, 12 insertions(+), 3 deletions(-)
> Index: test-2.6/arch/ia64/include/asm/ftrace.h
> ===================================================================
> --- test-2.6.orig/arch/ia64/include/asm/ftrace.h	2010-01-11 10:58:31.000000000 +0100
> +++ test-2.6/arch/ia64/include/asm/ftrace.h	2011-05-03 09:39:04.929486388 +0200
> @@ -14,8 +14,11 @@
>  
>  static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  {
> -	/* second bundle, insn 2 */
> -	return addr - 0x12;
> +	/*
> +	 * addr is the address of the mcount call instruction.
> +	 * recordmcount does the necessary offset calculation.
> +	 */
> +	return addr;
>  }
>  
>  struct dyn_arch_ftrace {
> Index: test-2.6/scripts/recordmcount.c
> ===================================================================
> --- test-2.6.orig/scripts/recordmcount.c	2011-05-03 09:39:02.145472579 +0200
> +++ test-2.6/scripts/recordmcount.c	2011-05-03 09:39:04.929486388 +0200
> @@ -307,7 +307,12 @@
>  	case EM_ARM:	 reltype = R_ARM_ABS32;
>  			 altmcount = "__gnu_mcount_nc";
>  			 break;
> -	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
> +	case EM_IA_64:
> +		reltype = R_IA64_IMM64;
> +		/* Adjust relocation to second bundle, insn 2 */
> +		mcount_adjust_32 = -18;
> +		gpfx = '_';
> +		break;
>  	case EM_MIPS:	 /* reltype: e_class    */ gpfx = '_'; break;
>  	case EM_PPC:	 reltype = R_PPC_ADDR32;   gpfx = '_'; break;
>  	case EM_PPC64:	 reltype = R_PPC64_ADDR64; gpfx = '_'; break;
> Index: test-2.6/scripts/recordmcount.pl
> ===================================================================
> --- test-2.6.orig/scripts/recordmcount.pl	2011-05-03 09:39:02.145472579 +0200
> +++ test-2.6/scripts/recordmcount.pl	2011-05-03 09:39:04.929486388 +0200
> @@ -278,6 +278,7 @@
>  
>  } elsif ($arch eq "ia64") {
>      $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
> +    $mcount_adjust = -18;
>      $type = "data8";
>  
>      if ($is_module eq "0") {
