Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261596AbULBLZf@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:47310 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261593AbULBLZe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2004 06:25:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16814.64421.960433.460117@cargo.ozlabs.ibm.com>
Date: Thu, 2 Dec 2004 22:25:25 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 9/11] - UML - fix signal mask on delivery error
In-Reply-To: <41AEE6A1.4020200@fujitsu-siemens.com>
References: <200411130201.iAD210pT005889@ccure.user-mode-linux.org>
	<20041112163442.45fc966f.akpm@osdl.org>
	<200411142213.iAEMDHbV013050@ccure.user-mode-linux.org>
	<1101826791.26071.108.camel@hades.cambridge.redhat.com>
	<41AEE6A1.4020200@fujitsu-siemens.com>
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>, blaisorblade_spam@yahoo.it, linux-arch@vger.kernel.org, jdike@ccure.user-mode-linux.org
List-ID: <linux-arch.vger.kernel.org>

Bodo Stroesser writes:

> If a SIGSEGV is forced since the stackframe/sigcontext for a signal-handler
> could not be created, this SIGSEGV is queued only. To deliver it, do_signal()
> must be called again, which normally won't happen (with the exception of
> sys_sigretrun/sys_rt_sigreturn). Thus, SIGSEGV stays in the queue until the

We got this right on ppc/ppc64, I believe.  After calling do_signal,
we loop around again (in the exception exit path in entry.S) and check
the signal pending and reschedule bits again (in the thread_info
flags).  We only exit to usermode when they are both zero.

Paul.
