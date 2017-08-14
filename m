From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Fwd: struct pt_regs missing in /usr/include/ tree for eBPF
 program compile
Date: Mon, 14 Aug 2017 14:08:07 +0200
Message-ID: <20170814120807.GB3305@osiris>
References: <c8a10777-9da1-461e-0b69-2c1280fa0ee7@linux.vnet.ibm.com>
 <49c5e39b-a7d9-1e2d-24ec-57852f7d1e51@linux.vnet.ibm.com>
 <CAADnVQKpaF+3EZKMtMBdKLatEQGytqc9YJQQSSFRFQ=7THpvTw@mail.gmail.com>
 <598492A6.10707@iogearbox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752964AbdHNMIO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Aug 2017 08:08:14 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7EC4HGO059936
        for <linux-arch@vger.kernel.org>; Mon, 14 Aug 2017 08:08:14 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2cb9yyccmk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 Aug 2017 08:08:14 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 14 Aug 2017 13:08:12 +0100
Content-Disposition: inline
In-Reply-To: <598492A6.10707@iogearbox.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, ast@kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, davem@davemloft.net, yhs@fb.com, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Fri, Aug 04, 2017 at 05:28:38PM +0200, Daniel Borkmann wrote:
> From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
> Date: Wed, Aug 2, 2017 at 1:22 AM
> [...]
> >I work on the perf tool and its bpf support for IBM s390 and came across a
> >strange issue compiling tools/testing/selftests/bpf/test_verifier.c on s390x.
> >
> >This is the compile error:
> >gcc -Wall -O2 -I../../../include/uapi -I../../../lib
> >-I../../../../include/generated
> >   -DHAVE_GENHDR -I../../../include    test_verifier.c
> >   /root/linux-devel/tools/testing/selftests/bpf/libbpf.a -lcap -lelf -o
> >   /root/linux-devel/tools/testing/selftests/bpf/test_verifier
> >In file included from test_verifier.c:63:0:
> >../../../include/uapi/linux/bpf_perf_event.h:14:17: error: field ‘regs’ has
> >   incomplete type struct pt_regs regs;
> 
> I actually came across the same issue today on s390
> while testing for something else.
> 
> >This shows up in test case "unpriv: spill/fill of different pointers ldx"
> >at line 1811.
> >This issue is located in file /usr/include/linux/bpf_perf_event.h which is a
> >copy of the linux kernels include/uapi/linux/bpf_perf_event.h.
> >
> >It contains:
> >struct bpf_perf_event_data {
> >         struct pt_regs regs;
> >         __u64 sample_period;
> >};
> 
> Yeah, correct.
> 
> >On s390 struct pt_regs is not exported to user space and does not appear
> >anywhere in /usr/include.
> >How about other architectures beside Intel?
> >As far as I know
> >1. the struct pt_regs contains only kernel registers, no user space registers?
> >2. Is part of the kernel API and should not be exported at all?
> 
> Looking into the tree, it appears that the following archs
> export a definition of struct pt_regs as uapi typically in
> arch/*/include/uapi/asm/ptrace.h: x86, sparc, power, mips,
> microblaze, alpha, unicore32, parisc, score, sh, mn10300,
> tile, m68k, m32r, ia64, hexagon, h8300, frv, cris, c6x.
> And for these I couldn't find it: s390, arc, arm64, nios2.
> 
> Anyone knows if there's any guidance on whether they must
> be exported or not? It appears at least the majority of
> archs is exporting them in one way or another.
> 
> Looking at 2dbb4c05d048 ("bpf/samples: Fix PT_REGS_IP on
> s390x and use it") and d912557b3460 ("samples: bpf: enable
> trace samples for s390x"), this was added by Michael for
> the programs themselves, which were using kernel headers
> for walking structs in BPF tracing programs, so a bit
> unrelated to the uapi issue actually, but given the
> test_verifier has couple of test cases containing pt_regs,
> they should probably do the same thing and be using kernel
> headers given tracing programs inspect kernel-internal
> data structures typically (see BPF tracing samples).
> 
> Now, I would like to avoid going down that road to pull
> in kernel internal headers into test_verifier.c, could
> we instead add a bpf_ptregs.h helper in tools/testing/selftests/bpf/,
> where s390 and arm64 would put a definition to fallback when
> otherwise not available? Admittedly, it's a bit of a hack
> if exporting them is not an option, but 'normal' tracing
> progs would consult kernel headers anyway. Thoughts?

I really don't think that struct pt_regs is part of uapi and should be
exported. We did change the layout of the pt_regs structure more than once
and would like to be able to do so in the future as well.

It looks like this is true for arm64 as well, since there only the first n
bytes of struct pt_regs are stable via their arch specific struct
user_pt_regs. However I don't know why even the first n bytes should be
considered uapi.

In addition what about compat processes? Most architectures define their
struct pt_regs with "unsigned long" members, which have different sizes for
32/64 bit, while the structure on the kernel stack contains 64 bit
members. And as far as I know the bpf test cases want to access the kernel
stack, no? Then this seems to be broken also.

We could add the hack you outlined above, but I'd like to have the same API
for all architectures. Otherwise we keep adding special cases for
architectures which don't export pt_regs via uapi (which I think is wrong).
