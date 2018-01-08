Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34601 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeAHVJj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jan 2018 16:09:39 -0500
Received: by mail-oi0-f65.google.com with SMTP id a70so2253338oib.1
        for <linux-arch@vger.kernel.org>; Mon, 08 Jan 2018 13:09:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFwa+1HiQo3aX9SZb21s7zQRqc5B40wgMMdsrYG0MJLknQ@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <CA+55aFzJgyk7peXyuNO8wgm0ZfSY2K-52XA9z=R6JGKcD6hQYw@mail.gmail.com>
 <CAPcyv4gx+2Dh6HS8e+TKNKP00+rYUkzGnEwdpZ_P6hFiOHKHNg@mail.gmail.com> <CA+55aFwa+1HiQo3aX9SZb21s7zQRqc5B40wgMMdsrYG0MJLknQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 8 Jan 2018 13:09:37 -0800
Message-ID: <CAPcyv4hVX4h9j-Uf=Ja5_0p3+qiWOiPd4cUaxoJD9en5TiVGPw@mail.gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>
Message-ID: <20180108210937.mKtDig-ObGL22i4D_ak6kwgx3wz5_zpTmz9whkaYks0@z>

On Sat, Jan 6, 2018 at 5:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Jan 6, 2018 at 3:31 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> I assume if we put this in uaccess_begin() we also need audit for
>> paths that use access_ok but don't do on to call uaccess_begin()? A
>> quick glance shows a few places where we are open coding the stac().
>> Perhaps land the lfence in stac() directly?
>
> Yeah, we should put it in uaccess_begin(), and in the actual user
> accessor helpers that do stac. Some of them probably should be changed
> to use uaccess_begin() instead while at it.
>
> One question for the CPU people: do we actually care and need to do
> this for things that might *write* to something? The speculative write
> obviously is killed, but does it perhaps bring in a cacheline even
> when killed?

As far as I understand a write could trigger a request-for-ownership
read for the target cacheline.

> Because maybe we don't need the lfence in put_user(), only in get_user()?

Even though writes can trigger reads, as far as I can see the write
needs to be dependent on the first out-of-bounds read:

if (x < max)
    y = array1[x];
    put_user(array2 + y, z);

...in other words that first read should be annotated with
nospec_array_ptr() making an lfence in put_user() or other writes
moot.

yp = nospec_array_ptr(array1, x, max);
if (yp)
    y = *yp;
    put_user(array2 + y, z);
