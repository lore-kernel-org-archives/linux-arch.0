Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23408 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754449Ab1EPTRR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 May 2011 15:17:17 -0400
From: "Luck, Tony" <tony.luck@intel.com>
Date: Mon, 16 May 2011 12:17:15 -0700
Subject: RE: [patch 3/4] ia64 mcount offset calculation
Message-ID: <987664A83D2D224EAE907B061CE93D5301CD197F7B@orsmsx505.amr.corp.intel.com>
References: <20110510081039.241831019@de.ibm.com>
	 <20110510081103.902546467@de.ibm.com>
 <1305572301.5456.24.camel@gandalf.stny.rr.com>
In-Reply-To: <1305572301.5456.24.camel@gandalf.stny.rr.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20110516191715.wVj23HevCEvp4v3bbVETIMaNszkqGvYOrwLQ2sCojcc@z>

I'm not sure how to test it - but it looks somewhat suspect.

The difficulty is in the way that ia64 tools report program addresses within bundles.

ia64 crams 3 41-bit instructions (and a 5-bit template) into a 16-byte "bundle".

Some tools report consecutive addresses like this:

0x000
0x001
0x002
0x010
0x011
0x012

where the low nibble is the instruction number within the bundle.  Others go
for:

0x000
0x006
0x00c
0x010
0x016
0x01c

with the illusion that instructions take 6-byte, 6bytes, 4-bytes.

This patch does some fast and loose translation from hex (0x12) in the kernel
to decimal (18) in the user tools ... which doesn't look like it fits with
either of these conventions.

-Tony

-----Original Message-----
From: linux-arch-owner@vger.kernel.org [mailto:linux-arch-owner@vger.kernel.org] On Behalf Of Steven Rostedt
Sent: Monday, May 16, 2011 11:58 AM
To: Luck, Tony
Cc: Martin Schwidefsky; linux-arch@vger.kernel.org
Subject: Re: [patch 3/4] ia64 mcount offset calculation

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


--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
