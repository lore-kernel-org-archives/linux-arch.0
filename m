From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [RFCv2 4/4] bpf: inhibit speculated out-of-bounds pointers
Date: Fri, 5 Jan 2018 09:04:52 -0800
Message-ID: <20180105170450.4trcy6qxr44nqglf@ast-mbp>
References: <20180105145750.53294-1-mark.rutland@arm.com>
 <20180105145750.53294-5-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44835 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeAERE5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jan 2018 12:04:57 -0500
Content-Disposition: inline
In-Reply-To: <20180105145750.53294-5-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dan.j.williams@intel.com, elena.reshetova@intel.com, corbet@lwn.net, alan@linux.intel.com, peterz@infradead.org, will.deacon@arm.com, gregkh@linuxfoundation.org, tglx@linutronix.de, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org

On Fri, Jan 05, 2018 at 02:57:50PM +0000, Mark Rutland wrote:
> Note: this patch is an *example* use of the nospec API. It is understood
> that this is incomplete, etc.
> 
> Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
> memory accesses under a bounds check may be speculated even if the
> bounds check fails, providing a primitive for building a side channel.
> 
> The EBPF map code has a number of such bounds-checks accesses in
> map_lookup_elem implementations. This patch modifies these to use the
> nospec helpers to inhibit such side channels.
> 
> The JITted lookup_elem implementations remain potentially vulnerable,
> and are disabled (with JITted code falling back to the C
> implementations).
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/bpf/arraymap.c | 20 +++++++++++++-------
>  kernel/bpf/cpumap.c   |  5 ++---
>  kernel/bpf/devmap.c   |  3 ++-
>  kernel/bpf/sockmap.c  |  3 ++-
>  4 files changed, 19 insertions(+), 12 deletions(-)

Mark, did you see my email with this patch yesterday ?
https://patchwork.ozlabs.org/patch/855911/

btw your patch does not fix the variant 1 exploit.

Also all of the pre-embargo patches from Elena that add lfence
in the bpf interpreter and x64 JIT also do not fix it.

The exploit works via bpf_tail_call and not via map_lookup.
I'm trying to make both safer with minimal run-time cost
with above patch.

Also as I tried to explain earlier the variant 1 is relying
on 64-bit speculative address math in bpf_tail_call
that was fixed into 32-bit math in October, so the risk is
close to zero already.

If both x64 and arm folks can test the above patch at least
we will be able to merge it and close one known hole in the tree.
In parallel we can work on adding nospec/osb primitives
and sprinkling them all over the kernel, but please do not use
bpf side as an 'example'. It's unnecessary.

Thanks
