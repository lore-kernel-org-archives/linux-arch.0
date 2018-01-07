From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sun, 7 Jan 2018 21:56:39 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1801072143370.2094@nanos>
References: <20180106183859.1ad9ae37@alans-desktop> <20180106185134.dzn2en4vw2hj3p6h@ast-mbp> <20180106195551.3207f75d@alans-desktop> <20180106200912.zhzdt4qmfrojeeqe@ast-mbp> <20180106202213.23e553fb@alans-desktop> <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop> <20180107033812.awq3vz4gdkps7tix@ast-mbp> <20180107063356.GA9425@1wt.eu> <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com> <20180107201211.GA9996@1wt.eu>
 <CA+55aFwYEr-x3teixCh5QtyMzXZKdNUkoF4xiw+1zg08PSsvpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47791 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeAGU5K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jan 2018 15:57:10 -0500
In-Reply-To: <CA+55aFwYEr-x3teixCh5QtyMzXZKdNUkoF4xiw+1zg08PSsvpw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Willy Tarreau <w@1wt.eu>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sun, 7 Jan 2018, Linus Torvalds wrote:
> We need to fix the security problem, but we need to do it *without*
> these braindead arguments that performance is somehow secondary.

I surely agree, but we have gone the way of PTI without the ability of
exempting individual processes exactly for one reason:

  Lack of time

It can be done on top of the PTI implementation and it won't take ages.

For spectre_v1/2 we face the same problem simply because we got informed so
much ahead of time and we were all twiddling thumbs, enjoying our christmas
vacation and having a good time.

The exploits are out in the wild and they are observed already, so we
really have to make a decision whether we want to fix that in the most
obvious ways even if it hurts performance right now and then take a break
from all that hell and sit down and sort the performance mess or whether we
want to discuss the right way to fix it for the next 3 month and leave all
doors open until the last bit of performance is squeezed out.

I totally can understand the anger of those who learned all of this a few
days ago and are now grasping straws to avoid the obviously coming
performance hit, but its not our fault that we have to make a decision
which cannot make everyone happy tomorrow.

If the general sentiment is that we have to fix the performance issue
first, then please let me know and I take 3 weeks of vacation right now.

Thanks,

	tglx
