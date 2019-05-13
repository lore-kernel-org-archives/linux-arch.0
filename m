Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:37433 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbfEMLdo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 May 2019 07:33:44 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
In-Reply-To: <CACT4Y+ad5z6z0Dweh5hGwYcUUebPEtqsznmX9enPvYB20J16aA@mail.gmail.com>
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com> <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr> <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com> <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com> <CACT4Y+ad5z6z0Dweh5hGwYcUUebPEtqsznmX9enPvYB20J16aA@mail.gmail.com>
Date: Mon, 13 May 2019 21:33:39 +1000
Message-ID: <87woiutwq4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Nick Kossifidis <mick@ics.forth.gr>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20190513113339.3j48GmhPdfAQl3uE1g02j9oyUXcYla6Tn9NZ1P-nJuc@z>

Dmitry Vyukov <dvyukov@google.com> writes:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Sat, May 11, 2019 at 2:51 AM
> To: Dmitry Vyukov
> Cc: Nick Kossifidis, Christoph Hellwig, Linus Torvalds, Andrew Morton,
> linux-arch, Linux Kernel Mailing List, linuxppc-dev
>
>> On Fri, May 10, 2019 at 6:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>> > >
>> > > I think it's good to have a sanity check in-place for consistency.
>> >
>> >
>> > Hi,
>> >
>> > This broke our cross-builds from x86. I am using:
>> >
>> > $ powerpc64le-linux-gnu-gcc --version
>> > powerpc64le-linux-gnu-gcc (Debian 7.2.0-7) 7.2.0
>> >
>> > and it says that it's little-endian somehow:
>> >
>> > $ powerpc64le-linux-gnu-gcc -dM -E - < /dev/null | grep BYTE_ORDER
>> > #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
>> >
>> > Is it broke compiler? Or I always hold it wrong? Is there some
>> > additional flag I need to add?
>>
>> It looks like a bug in the kernel Makefiles to me. powerpc32 is always
>> big-endian,
>> powerpc64 used to be big-endian but is now usually little-endian. There are
>> often three separate toolchains that default to the respective user
>> space targets
>> (ppc32be, ppc64be, ppc64le), but generally you should be able to build
>> any of the
>> three kernel configurations with any of those compilers, and have the Makefile
>> pass the correct -m32/-m64/-mbig-endian/-mlittle-endian command line options
>> depending on the kernel configuration. It seems that this is not happening
>> here. I have not checked why, but if this is the problem, it should be
>> easy enough
>> to figure out.
>
>
> Thanks! This clears a lot.
> This may be a bug in our magic as we try to build kernel files outside
> of make with own flags (required to extract parts of kernel
> interfaces).
> So don't spend time looking for the Makefile bugs yet.

OK :)

We did have some bugs in the past (~1-2 y/ago) but AFAIK they are all
fixed now. These days I build most of my kernels with a bi-endian 64-bit
toolchain, and switching endian without running `make clean` also works.

cheers
