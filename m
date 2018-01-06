From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sat, 6 Jan 2018 12:09:13 -0800
Message-ID: <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180106123242.77f4d860@alans-desktop>
 <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <20180106183859.1ad9ae37@alans-desktop>
 <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180106195551.3207f75d@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 06, 2018 at 07:55:51PM +0000, Alan Cox wrote:
> > cpus execute what they see. speculative execution does the same
> > except results are not committed to visible registers and stay
> > in renanmed/shadow set. There is no 'undo' of the speculative execution.
> > The whole issue is that cache and branch predictor don't have
> > a shadow unlike registers.
> 
> Can I suggest you read something like "Exploitig Value Locaity to Exceed
> The Dataflow Limit" by Lipasti and Shen 1996.

thanks for the pointer.
A quote from above paper:
"Value prediction consists of predicting entire 32- and 64-bit register values
based  on  previously-seen values"

> In other words there are at least two problems with Linus proposal
> 
> 1. The ffff/0000 mask has to be generated and that has to involve
> speculative flows.

to answer above and Thomas's
"For one particular architecture and that's not a solution for generic code."

The following:
#define array_access(base, idx, max) ({                         \
        union { typeof(base[0]) _val; unsigned long _bit; } __u;\
        unsigned long _i = (idx);                               \
        unsigned long _m = (max);                               \
        unsigned long _mask = ~(long)(_m - 1 - _i) >> 63;       \
        __u._val = base[_i & _mask];                            \
        __u._bit &= _mask;                                      \
        __u._val; })

is generic and no speculative flows.

> 2. There are processors on the planet that may speculate not just what
> instruction to execute but faced with a stall on an input continue by
> using an educated guess at the value that will appear at the input in
> future.

correct. that's why earlier I mentioned that "if 'mask' cannot
be influenced by attacker".
Even if 'mask' in 'index & mask' example is a stall the educated
guess will come from the prior value (according to the quoted paper)

To be honest I haven't read that particular paper in the past, but
abstracts fits my understanding and this array_access() proposal.
Thanks for the pointer. Will read it fully to make sure
I didn't miss anything.
