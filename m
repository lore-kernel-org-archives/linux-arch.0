From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHv3] Make for_each_cpu_mask a bit smaller
Date: Tue, 13 May 2008 14:02:42 +0200
Message-ID: <20080513120242.GD32022@elte.hu>
References: <20080511135039.GA3286@mailshack.com> <20080511091403.a75f5b78.pj@sgi.com> <20080511160658.GA3398@mailshack.com> <20080511160104.c3fef6bf.pj@sgi.com> <1210593896.23716.1252664185@webmail.messagingengine.com> <4828741B.2080802@sgi.com> <20080512190039.GA13324@mailshack.com> <jeej8742nt.fsf@sykes.suse.de> <20080513092821.GA20416@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:50013 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbYEMMDE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2008 08:03:04 -0400
Content-Disposition: inline
In-Reply-To: <20080513092821.GA20416@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: Andreas Schwab <schwab@suse.de>, Mike Travis <travis@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Jackson <pj@sgi.com>, Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>, ARCH <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexander van Heukelum <heukelum@fastmail.fm>


* Alexander van Heukelum <heukelum@mailshack.com> wrote:

> The for_each_cpu_mask loop is used quite often in the kernel. It makes 
> use of two functions: first_cpu and next_cpu. This patch changes 
> for_each_cpu_mask to use only the latter. Because next_cpu finds the 
> next eligible cpu _after_ the given one, the iteration variable has to 
> be initialized to -1 and next_cpu has to be called with this value 
> before the first iteration. An x86_64 defconfig kernel (from 
> sched/latest) is about 2500 bytes smaller with this patch applied:
> 
>    text	   data	    bss	    dec	    hex	filename
> 6222517	 917952	 749932	7890401	 7865e1	vmlinux.orig
> 6219922	 917952	 749932	7887806	 785bbe	vmlinux
> 
> The same size reduction is seen for defconfig+MAXSMP
> 
>    text	   data	    bss	    dec	    hex	filename
> 6241772	2563968	1492716	10298456	 9d2458	vmlinux.orig
> 6239211	2563968	1492716	10295895	 9d1a57	vmlinux

applied for testing, thanks Alexander.

	Ingo
