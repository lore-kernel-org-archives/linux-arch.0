Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261595AbULBLk5@vger.kernel.org>
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:19095 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261594AbULBLk5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Dec 2004 06:40:57 -0500
Message-ID: <41AEFF3E.1060605@fujitsu-siemens.com>
Date: Thu, 02 Dec 2004 12:40:46 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [PATCH 9/11] - UML - fix signal mask on delivery error
References: <200411130201.iAD210pT005889@ccure.user-mode-linux.org>	<20041112163442.45fc966f.akpm@osdl.org>	<200411142213.iAEMDHbV013050@ccure.user-mode-linux.org>	<1101826791.26071.108.camel@hades.cambridge.redhat.com>	<41AEE6A1.4020200@fujitsu-siemens.com> <16814.64421.960433.460117@cargo.ozlabs.ibm.com>
In-Reply-To: <16814.64421.960433.460117@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>, blaisorblade_spam@yahoo.it, linux-arch@vger.kernel.org, jdike@ccure.user-mode-linux.org
List-ID: <linux-arch.vger.kernel.org>

Paul Mackerras wrote:
> Bodo Stroesser writes:
> 
> 
>>If a SIGSEGV is forced since the stackframe/sigcontext for a signal-handler
>>could not be created, this SIGSEGV is queued only. To deliver it, do_signal()
>>must be called again, which normally won't happen (with the exception of
>>sys_sigretrun/sys_rt_sigreturn). Thus, SIGSEGV stays in the queue until the
> 
> 
> We got this right on ppc/ppc64, I believe.  After calling do_signal,
> we loop around again (in the exception exit path in entry.S) and check
> the signal pending and reschedule bits again (in the thread_info
> flags).  We only exit to usermode when they are both zero.
> 
> Paul.
Aha! Sorry, didn't recognize that loop.

Bodo
