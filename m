Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46905 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLPWu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2019 11:22:50 -0400
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
 <20190412145538.GA24473@lst.de>
In-Reply-To: <20190412145538.GA24473@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Apr 2019 17:22:32 +0200
Message-ID: <CAK8P3a0hNp39POcMD8nO5y487UAWEjmQzGyPbb4xW-o-R6HUCA@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, mick@ics.forth.gr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190412152232.jINrMUeTzRxWOSGPU-ksXYm7-q96vbzenuE-Ptt7wpI@z>

On Fri, Apr 12, 2019 at 4:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Apr 12, 2019 at 04:53:28PM +0200, Arnd Bergmann wrote:
> > On Fri, Apr 12, 2019 at 4:36 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > When removing some dead big endian checks in the RISC-V code Nick
> > > suggested that we should have some generic sanity checks.  I don't think
> > > we should have thos inside the RISC-V code, but maybe it might make
> > > sense to have these in the generic byteorder headers.  Note that these
> > > are UAPI headers and some compilers might not actually define
> > > __BYTE_ORDER__, so we first check that it actually exists.
> > >
> > > Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Extra checking like this is good in general, but I'm not sure I see
> > exactly what kind of issue one might expect to prevent with this:
>
> I'm personally not worried at all. Just trying to respond to Nicks
> review comment and make it reasonable generic if we have to have these
> checks at all.  I personally would be ok without them, I just don't
> want them hidden somewhere in the RISC-V code (RISC-V is always little
> endian at least right now).

Ok, makes sense.

Note: I hope we won't ever see big-endian RISC-V, I think that ship has
sailed long ago, regardless of any personal preferences one might hold.

The architectures that allow both (arm, arc, mips, c6x, microblaze,
modern ppc64, superh) tend to just use little-endian in practice, and the
ones that are hardcoded to big-endian (sparc, parisc, m68k, h8300, s390,
ppc32, some mips) are all 25+ years old and do so only for historic
reasons, with openrisc being the notable exception.

       Arnd
