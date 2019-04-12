Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43089 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbfDLOzv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Apr 2019 10:55:51 -0400
Date: Fri, 12 Apr 2019 16:55:38 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel
 endianess
Message-ID: <20190412145538.GA24473@lst.de>
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, mick@ics.forth.gr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190412145538._O0r8vQVBckqG4XWCNp-08WDR2jyawihxgUuNN1CRIY@z>

On Fri, Apr 12, 2019 at 04:53:28PM +0200, Arnd Bergmann wrote:
> On Fri, Apr 12, 2019 at 4:36 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > When removing some dead big endian checks in the RISC-V code Nick
> > suggested that we should have some generic sanity checks.  I don't think
> > we should have thos inside the RISC-V code, but maybe it might make
> > sense to have these in the generic byteorder headers.  Note that these
> > are UAPI headers and some compilers might not actually define
> > __BYTE_ORDER__, so we first check that it actually exists.
> >
> > Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Extra checking like this is good in general, but I'm not sure I see
> exactly what kind of issue one might expect to prevent with this:

I'm personally not worried at all. Just trying to respond to Nicks
review comment and make it reasonable generic if we have to have these
checks at all.  I personally would be ok without them, I just don't
want them hidden somewhere in the RISC-V code (RISC-V is always little
endian at least right now).
