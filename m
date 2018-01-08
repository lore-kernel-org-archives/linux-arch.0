From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [RFCv2 4/4] bpf: inhibit speculated out-of-bounds pointers
Date: Mon, 8 Jan 2018 12:59:25 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B802D72C7@IRSMSX102.ger.corp.intel.com>
References: <20180105145750.53294-1-mark.rutland@arm.com>
 <20180105145750.53294-5-mark.rutland@arm.com>
 <20180105170450.4trcy6qxr44nqglf@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180105170450.4trcy6qxr44nqglf@ast-mbp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "corbet@lwn.net" <corbet@lwn.net>, "alan@linux.intel.com" <alan@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

> On Fri, Jan 05, 2018 at 02:57:50PM +0000, Mark Rutland wrote:
> > Note: this patch is an *example* use of the nospec API. It is understood
> > that this is incomplete, etc.
> >
> > Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
> > memory accesses under a bounds check may be speculated even if the
> > bounds check fails, providing a primitive for building a side channel.
> >
> > The EBPF map code has a number of such bounds-checks accesses in
> > map_lookup_elem implementations. This patch modifies these to use the
> > nospec helpers to inhibit such side channels.
> >
> > The JITted lookup_elem implementations remain potentially vulnerable,
> > and are disabled (with JITted code falling back to the C
> > implementations).
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  kernel/bpf/arraymap.c | 20 +++++++++++++-------
> >  kernel/bpf/cpumap.c   |  5 ++---
> >  kernel/bpf/devmap.c   |  3 ++-
> >  kernel/bpf/sockmap.c  |  3 ++-
> >  4 files changed, 19 insertions(+), 12 deletions(-)
> 
> Mark, did you see my email with this patch yesterday ?
> https://patchwork.ozlabs.org/patch/855911/
> 
> btw your patch does not fix the variant 1 exploit.
> 
> Also all of the pre-embargo patches from Elena that add lfence
> in the bpf interpreter and x64 JIT also do not fix it.
> 
> The exploit works via bpf_tail_call and not via map_lookup.

Could you please clarify this part? The actual jump
to the out-of-bounds index is indeed made by bpf_tail_call, 
but the "speculation" bypassing step happens when it does map_lookup_elem
on the out-of-bound index.  


Best Regards,
Elena.
