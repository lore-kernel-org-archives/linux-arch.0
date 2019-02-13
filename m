Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36829 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfBMU7r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 15:59:47 -0500
MIME-Version: 1.0
References: <20190211174544.4302-1-will.deacon@arm.com> <20190211174544.4302-2-will.deacon@arm.com>
 <CAK8P3a1gmJTt+jdTbdSYZ0z43qodxf+co757K1-Hq1mj4fCqQA@mail.gmail.com> <20190213174608.GA29100@fuggles.cambridge.arm.com>
In-Reply-To: <20190213174608.GA29100@fuggles.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Feb 2019 21:59:28 +0100
Message-ID: <CAK8P3a1-CA_d+tRRKh50+7-PU14AV=9S1JUSF4d-VUxZ+DcW4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/io: Pass result on inX() accessor to __io_par()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, andrew.murray@arm.com, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Message-ID: <20190213205928.ylys4WbynoluzOmnv8ircg1pdFd7DfPH76dgkOFWCrQ@z>

On Wed, Feb 13, 2019 at 6:46 PM Will Deacon <will.deacon@arm.com> wrote:

> On Tue, Feb 12, 2019 at 12:55:17PM +0100, Arnd Bergmann wrote:
>
> > For all I can see, this should not conflict with the usage of the
> > same macros on RISC-V, though it does make add a significant
> > difference, so I'd like to see an Ack from the RISC-V folks as
> > well (added to Cc), or possibly a change to arch/riscv/include/asm/io.h
> > to do a corresponding change.
>
> There's already a comment in that header which says that the accesses are
> ordered wrt timer reads, so I don't think anything needs to change there.
> For consistency with the macro arguments, I could augment their __io_par to
> take the read value as an unused argument, if that's what you mean?

Yes, that's what I meant, I should have been clearer there.

     Arnd
