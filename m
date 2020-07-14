From: Christoph Hellwig <hch@lst.de>
Subject: Re: clean up address limit helpers
Date: Tue, 14 Jul 2020 09:09:55 +0200
Message-ID: <20200714070955.GB776@lst.de>
References: <20200710135706.537715-1-hch@lst.de> <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53012 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgGNHJ6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 03:09:58 -0400
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jul 10, 2020 at 08:25:35AM -0700, Linus Torvalds wrote:
> On Fri, Jul 10, 2020 at 6:57 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > in preparation for eventually phasing out direct use of set_fs(), this
> > series removes the segment_eq() arch helper that is only used to
> > implement or duplicate the uaccess_kernel() API, and then adds
> > descriptive helpers to force the kernel address limit.
> 
> Ack. All the patches looked like no-ops to me, but with better naming
> and clarity.

Is that a formal Acked-by?
