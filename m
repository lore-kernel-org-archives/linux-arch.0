Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46310 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfEOGxT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 May 2019 02:53:19 -0400
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
 <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr> <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com>
 <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com>
 <CACT4Y+ad5z6z0Dweh5hGwYcUUebPEtqsznmX9enPvYB20J16aA@mail.gmail.com>
 <87woiutwq4.fsf@concordia.ellerman.id.au> <CACT4Y+YT52wGuARxe9RqUsMYGNZTwaBowWWUUawyqTBq4G1NDg@mail.gmail.com>
 <20190513120435.GB22993@lst.de>
In-Reply-To: <20190513120435.GB22993@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 May 2019 08:53:02 +0200
Message-ID: <CAK8P3a2EF5ujv8S-PzYYBtNLEda+a_Wc6xhMign32QFnW4q1Ew@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dmitry Vyukov <dvyukov@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Nick Kossifidis <mick@ics.forth.gr>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <20190515065302.yZRAUVmN1BCX2eahIcH8FO9XtNhZY-zmBakyMYcZD0U@z>

On Mon, May 13, 2019 at 2:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, May 13, 2019 at 01:50:19PM +0200, Dmitry Vyukov wrote:
> > > We did have some bugs in the past (~1-2 y/ago) but AFAIK they are all
> > > fixed now. These days I build most of my kernels with a bi-endian 64-bit
> > > toolchain, and switching endian without running `make clean` also works.
> >
> > For the record, yes, it turn out to be a problem in our code (a latent
> > bug). We actually used host (x86) gcc to build as-if ppc code that can
> > run on the host, so it defined neither LE no BE macros. It just
> > happened to work in the past :)
>
> So Nick was right and these checks actually are useful..

Yes, definitely. I wonder if we should also bring back the word size check
from include/asm-generic/bitsperlong.h, which was disabled right
after I originally added that.

      Arnd
