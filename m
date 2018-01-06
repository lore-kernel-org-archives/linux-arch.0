Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38450 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbeAFSy2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 13:54:28 -0500
Received: by mail-oi0-f65.google.com with SMTP id r65so5093081oie.5
        for <linux-arch@vger.kernel.org>; Sat, 06 Jan 2018 10:54:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180106183937.vkseldf4arkdlkum@ast-mbp>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180106123242.77f4d860@alans-desktop> <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <CAPcyv4jqKmnkL1CfHVccHvocmSD4PamqOy4bPsO1789D+107FQ@mail.gmail.com> <20180106183937.vkseldf4arkdlkum@ast-mbp>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 6 Jan 2018 10:54:27 -0800
Message-ID: <CAPcyv4hyRfPhnnS=aDf=jMMP+-EJM3ojPC0gX9ChawT3vidkJQ@mail.gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180106185427.51oImfx9wtBAJrwkhqLtlKbPS1HuieDQP9_muZ-du7g@z>

On Sat, Jan 6, 2018 at 10:39 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[..]
>> retpoline is variant-2, this patch series is about variant-1.
>
> that's exactly the point. Don't slow down the kernel with lfences
> to solve variant 1. retpoline for 2 is ok from long term kernel
> viability perspective.
>

Setting aside that we still need to measure the impact of these
changes the end result will still be nospec_array_ptr() sprinkled in
various locations. So can we save the debate about what's inside that
macro on various architectures and at least proceed with annotating
the problematic locations? Perhaps we can go a step further and have a
config option to switch between the clever array_access() approach
from Linus that might be fine depending on the compiler, and the
cpu-vendor-recommended not to speculate implementation of
nospec_array_ptr().
