From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: Fwd: struct pt_regs missing in /usr/include/ tree for eBPF
 program compile
Date: Tue, 22 Aug 2017 22:01:11 -0700
Message-ID: <20170823050109.vyubf33dru2fdd3w@ast-mbp>
References: <c8a10777-9da1-461e-0b69-2c1280fa0ee7@linux.vnet.ibm.com>
 <49c5e39b-a7d9-1e2d-24ec-57852f7d1e51@linux.vnet.ibm.com>
 <CAADnVQKpaF+3EZKMtMBdKLatEQGytqc9YJQQSSFRFQ=7THpvTw@mail.gmail.com>
 <598492A6.10707@iogearbox.net>
 <20170814120807.GB3305@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33227 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdHWFBP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2017 01:01:15 -0400
Content-Disposition: inline
In-Reply-To: <20170814120807.GB3305@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, ast@kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, davem@davemloft.net, yhs@fb.com, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Mon, Aug 14, 2017 at 02:08:07PM +0200, Heiko Carstens wrote:
> > Now, I would like to avoid going down that road to pull
> > in kernel internal headers into test_verifier.c, could
> > we instead add a bpf_ptregs.h helper in tools/testing/selftests/bpf/,
> > where s390 and arm64 would put a definition to fallback when
> > otherwise not available? Admittedly, it's a bit of a hack
> > if exporting them is not an option, but 'normal' tracing
> > progs would consult kernel headers anyway. Thoughts?
>
> I really don't think that struct pt_regs is part of uapi and should be
> exported. We did change the layout of the pt_regs structure more than once
> and would like to be able to do so in the future as well.

I think Daniel's suggestion above it the best solution and doesn't
prevent future modification to pt_regs on s390.

> We could add the hack you outlined above, but I'd like to have the same API
> for all architectures. Otherwise we keep adding special cases for
> architectures which don't export pt_regs via uapi (which I think is wrong).

I don't see any other choice but to make this hack for s390/arm64
The programs need to be able to access the registers in the format that
kernel keeps, since the programs are attached to kprobe and perf_events
and are walking in-kernel data structures.
It's already well understood that kprobe+bpf is unstable api, so having
pt_regs being unstable on s390/arm64 doesn't make it any worse.
