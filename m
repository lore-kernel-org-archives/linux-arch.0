From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sat, 6 Jan 2018 23:05:07 +0000
Message-ID: <20180106230507.3547c9a0@alans-desktop>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
        <20180106123242.77f4d860@alans-desktop>
        <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
        <20180106183859.1ad9ae37@alans-desktop>
        <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
        <20180106195551.3207f75d@alans-desktop>
        <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
        <20180106202213.23e553fb@alans-desktop>
        <20180106211729.cp5oet3at3hyce4o@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180106211729.cp5oet3at3hyce4o@ast-mbp>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

> Even if it would be practical the speed probably going to be in bytes per second,
> so to read anything meaningful an attack detection techniques (that people
> are actively working on) will be able to catch it.
> At the end security cannot be absolute.
> The current level of paranoia shouldn't force us to make hastily decisions.

I think there are at least three overlapping problem spaces here

1.	This is a new field. That could mean that it turns out to be
really hard and everyone discovers that eBPF was pretty much the only
interesting attack. It could also mean we are going to see several years
or refinement by evil geniuses all over the world and what we see now is
tip of iceberg in cleverness.

2.	It is very very complicated to answer a question like "is
sequence x safe on all of vendor's microprocessors" even for the vendor

3.	A lot of people outside of the professional security space are
very new to the concept of security economics and risk management as
opposed to seeing the fake binary nice green tick that says their
computers are secure that they can pass to their senior management or
show to audit.

> So how about we do array_access() macro similar to above by default
> with extra CONFIG_ to convert it to lfence ?

We don't have to decide today. Intel's current position is 'lfence'. Over
time we may see vendors provide more sequences. We will see vendors add
new instruction hints and the like (See the ARM whitepaper for example)
and the array access code will change and change again for the better.

The important thing is that there is something clean, all architecture
that can be used today that doesn't keep forcing everyone to change
drivers when new/better ways to do the speculation management appear.

> Why default to AND approach instead of lfence ?
> Because the kernel should still be usable. If security
> sacrifices performance so much such security will be turned off.
> Ex: kpti suppose to add 5-30%. If it means 10% on production workload
> and the datacenter capacity cannot grow 10% overnight, kpti will be off.

The differences involved on the "lfence" versus "and" versus before are
not likely to be anywhere in that order of magnitude. As I said I want to
take a hard look at the IPv4/6 ones but most of them are not in places
where you'd expect a lot of data to be in flight in a perf critical path.

Alan
