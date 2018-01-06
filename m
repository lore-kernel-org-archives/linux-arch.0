From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sat, 6 Jan 2018 22:21:04 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1801062219270.2376@nanos>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com> <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com> <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180106123242.77f4d860@alans-desktop> <20180106181331.mmrqwwbu2jcjj2si@ast-mbp> <20180106183859.1ad9ae37@alans-desktop> <20180106185134.dzn2en4vw2hj3p6h@ast-mbp> <20180106195551.3207f75d@alans-desktop> <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop> <20180106211729.cp5oet3at3hyce4o@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeAFVVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 16:21:14 -0500
In-Reply-To: <20180106211729.cp5oet3at3hyce4o@ast-mbp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sat, 6 Jan 2018, Alexei Starovoitov wrote:
> So how about we do array_access() macro similar to above by default
> with extra CONFIG_ to convert it to lfence ?
> Why default to AND approach instead of lfence ?
> Because the kernel should still be usable. If security
> sacrifices performance so much such security will be turned off.
> Ex: kpti suppose to add 5-30%. If it means 10% on production workload
> and the datacenter capacity cannot grow 10% overnight, kpti will be off.

That's the decision and responsibility of the person who disables it.

Thanks,

	tglx
