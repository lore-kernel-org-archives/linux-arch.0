From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sun, 7 Jan 2018 12:15:40 -0800
Message-ID: <CAPcyv4gm0tAbLHHyMvsbghV+SpnbaTCmJd6N8imwUnRZ9k2xUA@mail.gmail.com>
References: <20180106123242.77f4d860@alans-desktop> <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <20180106183859.1ad9ae37@alans-desktop> <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop> <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop> <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop> <20180107033812.awq3vz4gdkps7tix@ast-mbp>
 <20180107063356.GA9425@1wt.eu> <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:39892 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754536AbeAGUPm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jan 2018 15:15:42 -0500
Received: by mail-oi0-f50.google.com with SMTP id r63so6193028oia.6
        for <linux-arch@vger.kernel.org>; Sun, 07 Jan 2018 12:15:41 -0800 (PST)
In-Reply-To: <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Willy Tarreau <w@1wt.eu>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Sun, Jan 7, 2018 at 11:47 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Jan 6, 2018 at 10:33 PM, Willy Tarreau <w@1wt.eu> wrote:
>>
>> To be fair there's overreaction on both sides. The vast majority of
>> users need to get a 100% safe system and will never notice  any
>> difference.
>
> There is no such thing as a "100% safe system". Never will be - unless
> you make sure you have no users.
>
> Also, people definitely *are* noticing the performance issues with the
> current set of patches, and they are causing real problems. Go search
> for reports of Amazon AWS slowdowns.
>
> So this whole "security is so important that performance doesn't
> matter" mindset is pure and utter garbage.
>
> And the whole "normal people won't even notice" is pure garbage too.
> Don't spread that bullshit when you see actual normal people
> complaining.
>
> Performance matters. A *LOT*.

I'm thinking we should provide the option to at least build the
hot-path nospec_array_ptr() usages without an lfence.

    CONFIG_SPECTRE1_PARANOIA_SAFE
    CONFIG_SPECTRE1_PARANOIA_PERF

...if only for easing performance testing and let the distribution set
its policy.

Where hot-path usages can do:

    nospec_relax(nospec_array_ptr())

...to optionally ellide the lfence.
