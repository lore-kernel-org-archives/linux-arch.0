Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f178.google.com ([74.125.82.178]:42940 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbeAFXbz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 18:31:55 -0500
Received: by mail-ot0-f178.google.com with SMTP id d2so6634974oth.9
        for <linux-arch@vger.kernel.org>; Sat, 06 Jan 2018 15:31:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFzJgyk7peXyuNO8wgm0ZfSY2K-52XA9z=R6JGKcD6hQYw@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com> <CA+55aFzJgyk7peXyuNO8wgm0ZfSY2K-52XA9z=R6JGKcD6hQYw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 6 Jan 2018 15:31:54 -0800
Message-ID: <CAPcyv4gx+2Dh6HS8e+TKNKP00+rYUkzGnEwdpZ_P6hFiOHKHNg@mail.gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>
Message-ID: <20180106233154.X_DS4PAl5SF_awyWng4xxX78OGoiZQeE7hDHRWug-rA@z>

On Fri, Jan 5, 2018 at 7:09 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jan 5, 2018 at 6:52 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The fact is, we have to stop speculating when access_ok() does *not*
>> fail - because that's when we'll actually do the access. And it's that
>> access that needs to be non-speculative.
>
> I also suspect we should probably do this entirely differently.
>
> Maybe the whole lfence can be part of uaccess_begin() instead (ie
> currently 'stac()'). That would fit the existing structure better, I
> think. And it would avoid any confusion about the whole "when to stop
> speculation".

I assume if we put this in uaccess_begin() we also need audit for
paths that use access_ok but don't do on to call uaccess_begin()? A
quick glance shows a few places where we are open coding the stac().
Perhaps land the lfence in stac() directly?
