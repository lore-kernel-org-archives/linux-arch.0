From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sun, 7 Jan 2018 07:33:56 +0100
Message-ID: <20180107063356.GA9425@1wt.eu>
References: <20180106123242.77f4d860@alans-desktop>
 <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <20180106183859.1ad9ae37@alans-desktop>
 <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
 <20180107033812.awq3vz4gdkps7tix@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180107033812.awq3vz4gdkps7tix@ast-mbp>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 06, 2018 at 07:38:14PM -0800, Alexei Starovoitov wrote:
> yep. plenty of unknowns and what's happening now is an overreaction.

To be fair there's overreaction on both sides. The vast majority of
users need to get a 100% safe system and will never notice  any
difference. A few of us are more concerned by the risk of performance
loss brought by these fixes. We do all need to run tests on the
patchsets to bring numbers on the table.

> What is the rush to push half baked patches into upstream
> that don't even address the variant 1 ?

You probably need to trust the CPU vendors a bit for having had all
the details about the risks for a few months now and accept that if
they're destroying their product's performance compared to their main
competitor, they probably studied a number of other alternatives first.
It doesn't mean they thought about everything of course, and maybe they
need to study your proposal as a better solution to reduce criticism.

> which clearly states that bpf_tail_call() was used in the attack.
> Yet none of the intel nor arm patches address speculation in
> this bpf helper!
> It means that:
> - gpz didn't share neither exploit nor the detailed description
>   of the POC with cpu vendors until now

Or it was considered less urgent to fix compared to the rest. It's
also possible that the scariest details were not written in the GPZ
article.

> Now the attack is well described, yet cpu vendors still pushing
> for lfence patches that don't make sense. Why?

Imagine if you were in their position and were pushing a solution which
would later be found to be inefficient and to be vulnerable again. Your
name would appear twice in the press in a few months, this would be
terrible. It makes sense in their position to find the safest fix first
given that those like you or me really concerned about the performance
impact know how to add an option to a boot loader or revert a patch that
causes trouble.

> What I think is important is to understand vulnerability first.
> I don't think it was done.

I suspect it was clearly done by those how had no other option but
working on this painful series over the last few months :-/

> > The differences involved on the "lfence" versus "and" versus before are
> > not likely to be anywhere in that order of magnitude.
> 
> we clearly disagree here. Both intel and arm patches proposed
> to add lfence in bpf_map_lookup() which is the hottest function
> we have and we do run it at 40+Gbps speeds where every nanosecond
> counts, so no, lfence is not a solution.

Please help here by testing the patch series and reporting numbers
before, with the fix, and with your proposal. That's the best way to
catch their attention and to get your proposal considered as a viable
alternative (or as a partial one for certain environments). I did the
same when I believed it could be sufficient to add noise to RDTSC and
found it totally inefficient after testing. But it's better for
everyone that research and testing is done rather than criticizing the
proposed fixes (which is not fair to the people who work hard on them
for everyone else).

Cheers,
Willy
