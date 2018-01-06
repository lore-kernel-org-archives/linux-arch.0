From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Fri, 5 Jan 2018 21:47:02 -0800
Message-ID: <CAPcyv4jLbbASjcfu2dvxXbY8+Q_=wLO6zKGhCBdzRGXHBNuL1w@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:43443 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeAFFrF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 00:47:05 -0500
Received: by mail-oi0-f41.google.com with SMTP id f69so4418064oig.10
        for <linux-arch@vger.kernel.org>; Fri, 05 Jan 2018 21:47:03 -0800 (PST)
In-Reply-To: <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>

On Fri, Jan 5, 2018 at 6:52 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jan 5, 2018 at 5:10 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> From: Andi Kleen <ak@linux.intel.com>
>>
>> When access_ok fails we should always stop speculating.
>> Add the required barriers to the x86 access_ok macro.
>
> Honestly, this seems completely bogus.
>
> The description is pure garbage afaik.
>
> The fact is, we have to stop speculating when access_ok() does *not*
> fail - because that's when we'll actually do the access. And it's that
> access that needs to be non-speculative.
>
> That actually seems to be what the code does (it stops speculation
> when __range_not_ok() returns false, but access_ok() is
> !__range_not_ok()). But the explanation is crap, and dangerous.

Oh, bother, yes, good catch. It's been a long week.  I'll take a look
at moving this to uaccess_begin().
