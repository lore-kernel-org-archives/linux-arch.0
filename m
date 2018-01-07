From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sun, 7 Jan 2018 12:17:11 -0800
Message-ID: <CA+55aFwYEr-x3teixCh5QtyMzXZKdNUkoF4xiw+1zg08PSsvpw@mail.gmail.com>
References: <20180106183859.1ad9ae37@alans-desktop> <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop> <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop> <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop> <20180107033812.awq3vz4gdkps7tix@ast-mbp>
 <20180107063356.GA9425@1wt.eu> <CA+55aFzqb-p_Ng2nsXvFsibtNC2rH5fwrefwnwA3TTFVtzM3FA@mail.gmail.com>
 <20180107201211.GA9996@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180107201211.GA9996@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 7, 2018 at 12:12 PM, Willy Tarreau <w@1wt.eu> wrote:
>
> Linus, no need to explain that to me, I'm precisely trying to see how
> to disable PTI for a specific process because I face up to 45% loss in
> certain circumstances, making it a no-go. But while a few of us have
> very specific workloads emphasizing this impact, others have very
> different ones and will not notice. For example my laptop did boot
> pretty fine and I didn't notice anything until I fire a network
> benchmark.

Sure, most people have hardware where the bottleneck is entirely
elsewhere (slow network, rotating disk, whatever).

But this whole "normal people won't notice" is dangerous thinking.
They may well notice very much, we simply don't know what they are
doing.

Quite honesty, it's equally correct to say "normal people won't be
affected by the security issue in the first place".

That laptop that you didn't have any issues with? Likely it never had
an exploit running on it either!

So the whole "normal people" argument is pure and utter garbage. It's
wrong. It's pure shit when it comes to performance, but it's also pure
shit when it comes to the security issue.

Don't use it.

We need to fix the security problem, but we need to do it *without*
these braindead arguments that performance is somehow secondary.

               Linus
