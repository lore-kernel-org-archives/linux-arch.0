Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33991 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeIOBLg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2018 21:11:36 -0400
MIME-Version: 1.0
References: <20180914113929.953895-1-arnd@arndb.de> <20180914174528.GA35000@gmail.com>
In-Reply-To: <20180914174528.GA35000@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 14 Sep 2018 21:55:21 +0200
Message-ID: <CAK8P3a03qF4+yGBNVLymrSRN7QjDGjnpduoPwnprwv+kfHZ0Cg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] making uapi/linux/elfcore.h useful again
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Joseph Myers <joseph@codesourcery.com>, David Howells <dhowells@redhat.com>, GNU C Library <libc-alpha@sourceware.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180914195521.DXYx7VJuBOBRZu93997-EkMrYWNPPp_txr9L2ruQU8Q@z>

On Fri, Sep 14, 2018 at 7:45 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Arnd Bergmann <arnd@arndb.de> wrote:
> > - Move required data from the private x86 asm/elf.h file into
> >   a new uapi/asm/elf.h. Some other architectures already do that,
> >   but most of them do not. Before applying the patch, we have
> >   to do this for all architectures
>
> Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

> I suspect this wants to go through -mm, or do you want to carry it?

-mm is probably best. For now, I just want to see if there are any
concerns about this, and then I'd have to do the full version that
changes all architectures.

     Arnd
