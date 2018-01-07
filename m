From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sun, 7 Jan 2018 21:12:11 +0100
Message-ID: <20180107201211.GA9996@1wt.eu>
References: <20180106183859.1ad9ae37@alans-desktop>
 <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
 <20180107033812.awq3vz4gdkps7tix@ast-mbp>
 <20180107063356.GA9425@1wt.eu>
 <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:38744 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754497AbeAGUMr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 7 Jan 2018 15:12:47 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Sun, Jan 07, 2018 at 11:47:07AM -0800, Linus Torvalds wrote:
> And the whole "normal people won't even notice" is pure garbage too.
> Don't spread that bullshit when you see actual normal people
> complaining.
> 
> Performance matters. A *LOT*.

Linus, no need to explain that to me, I'm precisely trying to see how
to disable PTI for a specific process because I face up to 45% loss in
certain circumstances, making it a no-go. But while a few of us have
very specific workloads emphasizing this impact, others have very
different ones and will not notice. For example my laptop did boot
pretty fine and I didn't notice anything until I fire a network
benchmark.

Willy
