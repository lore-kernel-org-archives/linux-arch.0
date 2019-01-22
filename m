Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45744 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfAVJha (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jan 2019 04:37:30 -0500
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
In-Reply-To: <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 22 Jan 2019 10:37:12 +0100
Message-ID: <CAK8P3a2sMgHWpSV8OAa7LCo6oQiQ4xd5WQHKJ1-tN0TV8uRDHQ@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, alpha <linux-alpha@vger.kernel.org>
Message-ID: <20190122093712.23haU7ati9pZeJIQvxWs0zV41LsGmcaDT_Jn9lX7uc8@z>

On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I have a patch that I'll send soon to make x32 use its own table.  As
> far as I'm concerned, 547 is *it*.  548 is just a normal number and is
> not special.  But let's please not reuse 512..547 for other purposes
> on x86 variants -- that way lies even more confusion, IMO.

(trimming Cc list, as this is getting a little off-topic most most)

Just so I understand: do you mean duplicating the .tbl file, or just
the resulting table of entry points?

In either way, how will that work with the new io_uring_setup()
system call that will have to use the compat entry point?
Are you planning to use the same syscall number as x86_64
but point it to the compat function, or do we still need a new
syscall number for x32 in the regular range?

       Arnd
