Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34637 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439AbbEMJq2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 05:46:28 -0400
Date: Wed, 13 May 2015 11:46:23 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH v3] Documentation/arch: Add Documentation/arch-TODO
Message-ID: <20150513094622.GC11030@gmail.com>
References: <20150511192918.GA11361@jtriplet-mobl1>
 <20150512142250.dcb053da81855ae1b5861173@linux-foundation.org>
 <20150512213843.GV21418@twins.programming.kicks-ass.net>
 <20150512144910.0b49c9a7a13336773449db33@linux-foundation.org>
 <20150513083441.GA17336@gmail.com>
 <20150513085636.GA11030@gmail.com>
 <20150513092421.GB11030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150513092421.GB11030@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Josh Triplett <josh@joshtriplett.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Message-ID: <20150513094623.Uzh9SYPGndM6kSS3TL_UXP1tDy_bDLJUyHUzFj-qIK4@z>


So this is the final version for now:

 - add a fourth table

 - fix errors in earlier tables, in particular I missed some PowerPC 
   Kconfigs

 - introduce the '..' denotion (in the final table) to show features 
   that cannot be supported by an architecture due to hardware 
   dependencies:

		   gcov-profile-all:---------------.
				THP:--------.      |
		      irq-time-acct:-.      |      |
				     |      |      |
		----------------------------------------
		  alpha           | TODO | TODO | TODO |
		  arc             | TODO |  ..  | TODO |
		  arm             |  ok  |  ok  |  ok  |
		  arm64           | TODO |  ok  |  ok  |
		  avr32           | TODO |  ..  | TODO |
		  blackfin        | TODO |  ..  | TODO |
		  c6x             | TODO |  ..  | TODO |

   so in the 'THP' column, if an architecture could in theory support 
   THP, it's listed as 'TODO', if it cannot, it's listed as '..'.

Please let me know about errors in these tables, and I can also add 
more features/facilities as well if I missed any.

Thanks,

    Ingo

==========================>
