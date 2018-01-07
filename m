From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sun, 7 Jan 2018 13:59:35 +0000
Message-ID: <20180107135935.6ecfabd5@alans-desktop>
References: <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
        <20180106123242.77f4d860@alans-desktop>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:57812 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753951AbeAGOAO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 7 Jan 2018 09:00:14 -0500
In-Reply-To: <20180107033812.awq3vz4gdkps7tix@ast-mbp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

> > 2.	It is very very complicated to answer a question like "is
> > sequence x safe on all of vendor's microprocessors" even for the vendor  
> 
> so far "is sequence x safe" was viewed by cpu vendors as
> "is sequence x going to stop speculative execution".

Incorrect. Modern processors are very very sophisticated beasts and you
are dealing with a wide range of architectures and micro-architectures
that all have their own differences.

> > Intel's current position is 'lfence'.  

> which clearly states that bpf_tail_call() was used in the attack.
> Yet none of the intel nor arm patches address speculation in
> this bpf helper!

There are a set of patches under discussion for eBPF both the JIT and
interpreter. BTW I would expect that there are things Coverity didn't
find, and that we'll also see variants on the attack where different
tricks for measurement emerge that may change what is needed a little.

> which means that POC is relying 64-bit address speculation.
> In the places coverity found the user supplied value is 32-bit,

People have 32bit computers as well as 64bit and in some cases 32bit is
fine for an attack depending where your target is relative to the object.

> > The differences involved on the "lfence" versus "and" versus before are
> > not likely to be anywhere in that order of magnitude.  
> 
> we clearly disagree here. Both intel and arm patches proposed
> to add lfence in bpf_map_lookup() which is the hottest function
> we have and we do run it at 40+Gbps speeds where every nanosecond
> counts, so no, lfence is not a solution.

The last solution I saw proposed in that path for the JIT is to "and" with
constant which in that situation clearly makes the most sense providing
it is safe on all the CPUs involved.

lfence timing is also heavily dependent upon what work has to be done to
retire previous live instructions. BPF does not normally do a lot of
writing so you'd expect the cost to be low.

Anyway - Intel's current position is that lfence is safe. It's not
impossible other sequences will in future be documented as safe by one or
more vendors of x86 processors.

Alan
