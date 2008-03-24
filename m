Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:56355 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321AbYCXHzu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 24 Mar 2008 03:55:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18407.24189.707297.767237@cargo.ozlabs.ibm.com>
Date: Mon, 24 Mar 2008 18:55:41 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/8] powerpc ptrace: forced_successful_syscall_return()
In-Reply-To: <20080319211936.28E8B26F9A7@magilla.localdomain>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319211936.28E8B26F9A7@magilla.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, Richard Henderson <rth@twiddle.net>, tony.luck@intel.com, linux-ia64@vger.kernel.org
Message-ID: <20080324075541.oGMAcWIei7KLVqTmx5WusNWRVbehw3WuKoMw03MJuYQ@z>

Roland McGrath writes:

> Define the forced_successful_syscall_return() macro to
> pair with our force_successful_syscall_return() definition.
> 
> Signed-off-by: Roland McGrath <roland@redhat.com>

Looks OK to me, but what's it useful for?

Paul.
