From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sun, 7 Jan 2018 11:08:24 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1801071107001.2606@nanos>
References: <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com> <20180106123242.77f4d860@alans-desktop> <20180106181331.mmrqwwbu2jcjj2si@ast-mbp> <20180106183859.1ad9ae37@alans-desktop> <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop> <20180106200912.zhzdt4qmfrojeeqe@ast-mbp> <20180106202213.23e553fb@alans-desktop> <20180106211729.cp5oet3at3hyce4o@ast-mbp> <20180106230507.3547c9a0@alans-desktop> <20180107033812.awq3vz4gdkps7tix@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47240 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeAGKI6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jan 2018 05:08:58 -0500
In-Reply-To: <20180107033812.awq3vz4gdkps7tix@ast-mbp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sat, 6 Jan 2018, Alexei Starovoitov wrote:
> which clearly states that bpf_tail_call() was used in the attack.
> Yet none of the intel nor arm patches address speculation in
> this bpf helper!
> It means that:
> - gpz didn't share neither exploit nor the detailed description
>   of the POC with cpu vendors until now
> - coverity rules used to find all these places in the kernel
>   failed to find bpf_tail_call
> - cpu vendors were speculating what variant 1 can actually do

You forgot to mention that there might be other attacks than the public POC
which are not covered by a simple AND ....

Thanks,

	tglx
