Return-Path: <SRS0=nKtn=64=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728928AbgENW4u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 May 2020 18:56:50 -0400
Date: Thu, 14 May 2020 15:56:46 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: implement BPF ring buffer and verifier
 support for it
Message-ID: <20200514225646.4kgc7lrsviusujg2@ast-mbp.dhcp.thefacebook.com>
References: <20200513192532.4058934-1-andriin@fb.com>
 <20200513192532.4058934-2-andriin@fb.com>
 <20200514121848.052966b3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87h7wixndi.fsf@nanos.tec.linutronix.de>
 <CAEf4Bzbj-WvRkoGxkSFtK5_1JfQxthoFid398C97RM0ppBb0dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbj-WvRkoGxkSFtK5_1JfQxthoFid398C97RM0ppBb0dA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-arch@vger.kernel.org, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>
Message-ID: <20200514225646.RMllrIpCsvx50fs7h7Jvtq9PxzYxKoru4b29CmRiA9Q@z>

On Thu, May 14, 2020 at 02:30:11PM -0700, Andrii Nakryiko wrote:
> On Thu, May 14, 2020 at 1:39 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Jakub Kicinski <kuba@kernel.org> writes:
> >
> > > On Wed, 13 May 2020 12:25:27 -0700 Andrii Nakryiko wrote:
> > >> One interesting implementation bit, that significantly simplifies (and thus
> > >> speeds up as well) implementation of both producers and consumers is how data
> > >> area is mapped twice contiguously back-to-back in the virtual memory. This
> > >> allows to not take any special measures for samples that have to wrap around
> > >> at the end of the circular buffer data area, because the next page after the
> > >> last data page would be first data page again, and thus the sample will still
> > >> appear completely contiguous in virtual memory. See comment and a simple ASCII
> > >> diagram showing this visually in bpf_ringbuf_area_alloc().
> > >
> > > Out of curiosity - is this 100% okay to do in the kernel and user space
> > > these days? Is this bit part of the uAPI in case we need to back out of
> > > it?
> > >
> > > In the olden days virtually mapped/tagged caches could get confused
> > > seeing the same physical memory have two active virtual mappings, or
> > > at least that's what I've been told in school :)
> >
> > Yes, caching the same thing twice causes coherency problems.
> >
> > VIVT can be found in ARMv5, MIPS, NDS32 and Unicore32.
> >
> > > Checking with Paul - he says that could have been the case for Itanium
> > > and PA-RISC CPUs.
> >
> > Itanium: PIPT L1/L2.
> > PA-RISC: VIPT L1 and PIPT L2
> >
> > Thanks,
> >
> 
> Jakub, thanks for bringing this up.
> 
> Thomas, Paul, what kind of problems are we talking about here? What
> are the possible problems in practice?

VIVT cpus will have issues with coherency protocol between cpus.
I don't think it applies to this case.
Here all cpus we have the same phys page seen in two virtual pages.
That mapping is the same across all cpus.
But any given range of virtual addresses in these two pages will
be accessed by only one cpu at a time.
At least that's my understanding of Andrii's algorithm.
We probably need to white board the overlapping case a bit more.
Worst case I think it's fine to disallow this new ring buffer
on such architectures. The usability from bpf program side
is too great to give up.
