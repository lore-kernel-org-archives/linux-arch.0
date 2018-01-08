From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sun, 7 Jan 2018 18:24:11 -0800
Message-ID: <20180108022409.q2riz6wzbcm3dkx6@ast-mbp>
References: <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
 <20180107033812.awq3vz4gdkps7tix@ast-mbp>
 <20180107063356.GA9425@1wt.eu>
 <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
 <CAPcyv4gm0tAbLHHyMvsbghV+SpnbaTCmJd6N8imwUnRZ9k2xUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4gm0tAbLHHyMvsbghV+SpnbaTCmJd6N8imwUnRZ9k2xUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 07, 2018 at 12:15:40PM -0800, Dan Williams wrote:
> 
> I'm thinking we should provide the option to at least build the
> hot-path nospec_array_ptr() usages without an lfence.
> 
>     CONFIG_SPECTRE1_PARANOIA_SAFE
>     CONFIG_SPECTRE1_PARANOIA_PERF

SAFE vs PERF naming is problematic and misleading, since users don't
have the data to make a decision they will be forced to go with SAFE.

What is not safe about array_access() macro with AND ?
How lfence approach makes it safer ?
Only because lfence was blessed by intel earlier when
they couldn't figure out a different way?

How about:
CONFIG_SPECTRE1_WORKAROUND_INDEX_MASK
CONFIG_SPECTRE1_WORKAROUND_LOAD_FENCE

> ...if only for easing performance testing and let the distribution set
> its policy.
> 
> Where hot-path usages can do:
> 
>     nospec_relax(nospec_array_ptr())

AND approach doesn't prevent speculation hence nospec_ is an incorrect prefix.
Alan's "speculation management" terminology fits well here.

Can we keep array_access() name and change it underneath to
either mask or lfence ?
