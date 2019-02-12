Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35174 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLLzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 06:55:35 -0500
MIME-Version: 1.0
References: <20190211174544.4302-1-will.deacon@arm.com> <20190211174544.4302-2-will.deacon@arm.com>
In-Reply-To: <20190211174544.4302-2-will.deacon@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 12 Feb 2019 12:55:17 +0100
Message-ID: <CAK8P3a1gmJTt+jdTbdSYZ0z43qodxf+co757K1-Hq1mj4fCqQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/io: Pass result on inX() accessor to __io_par()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, andrew.murray@arm.com, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Message-ID: <20190212115517.bvAHw0mRJxhNUht7PE56BAGaHq9e0CD3nd03lZ5CCdo@z>

On Mon, Feb 11, 2019 at 6:45 PM Will Deacon <will.deacon@arm.com> wrote:
>
> The inX() I/O accessors must enforce ordering against subsequent calls
> to the delay() routines, so that a read-back from a device can be used
> to postpone a subsequent write to the same device.
>
> On some architectures, including arm64, this ordering can only be
> achieved by creating a dependency on the value returned by the inX()
> operation, so we need to pass the value we read to the __io_par()
> macro in this case.
>
> Reported-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/asm-generic/io.h | 8 ++++----

For changing the asm-generic file in the arm64 tree,

Acked-by: Arnd Bergmann <arnd@arndb.de>

For all I can see, this should not conflict with the usage of the
same macros on RISC-V, though it does make add a significant
difference, so I'd like to see an Ack from the RISC-V folks as
well (added to Cc), or possibly a change to arch/riscv/include/asm/io.h
to do a corresponding change.

       Arnd
