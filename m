From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sat, 6 Jan 2018 21:42:29 +0100
Message-ID: <20180106204229.GD9075@1wt.eu>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180106123242.77f4d860@alans-desktop>
 <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <20180106183859.1ad9ae37@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:38597 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752213AbeAFUnB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Jan 2018 15:43:01 -0500
Content-Disposition: inline
In-Reply-To: <20180106183859.1ad9ae37@alans-desktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Sat, Jan 06, 2018 at 06:38:59PM +0000, Alan Cox wrote:
> Normally people who propose security fixes don't have to argue about the
> fact they added 30 clocks to avoid your box being 0wned.

In fact it depends, because if a fix makes the system unusable for its
initial purpose, this fix will simply not be deployed at all, which is
the worst that can happen. Especially when it cannot be disabled by
config and people stop updating their systems to stay on the last
"known good" version. Fortunately in Linux we often have the choice so
that users rarely have a valid reason for not upgrading!

Willy
