Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:41745 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbYCTHkM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Mar 2008 03:40:12 -0400
Date: Thu, 20 Mar 2008 03:40:05 -0400
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 6/8] ptrace: arch_ptrace -ENOSYS return
Message-ID: <20080320074005.GB19969@infradead.org>
References: <20080319211714.8B14226F995@magilla.localdomain> <20080319212024.EA03126F995@magilla.localdomain> <alpine.LFD.1.00.0803191935080.3020@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803191935080.3020@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Richard Henderson <rth@twiddle.net>, tony.luck@intel.com, linux-ia64@vger.kernel.org
Message-ID: <20080320074005.qhDvdaOcS4l_e6Bvl0mDqdaNgS5BSihw0Uuo3CY7Gc0@z>

On Wed, Mar 19, 2008 at 07:40:25PM -0700, Linus Torvalds wrote:
> 
> And I have to say, I really hate that
> 
> 		ret = arch_ptrace(child, request, addr, data);
> 		if (ret == -ENOSYS && !forced_successful_syscall_return())
> 			ret = ptrace_request(child, request, addr, data);
> 
> thing. Instead of doing it that ugly way (return value and a special 
> per-arch forced_successful_syscall_return() thing), this really smells 
> like you just want to change the calling conventions for "arch_ptrace()" 
> instead.
> 
> Wouldn't it be nicer to just let "arch_ptrace()" return a flag saying 
> whether it handled things or not?

I think the easiest and cleanest would be to just drop this whole
series.  There's no inherent advantage of

	ret = -ENOSYS;

in the arch_ptrace default case over

	ret = ptrace_request(...);

