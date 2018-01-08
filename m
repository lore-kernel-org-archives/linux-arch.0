From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Sun, 7 Jan 2018 18:57:35 -0800
Message-ID: <20180108025732.2mnqgqivnh5u5mfb@ast-mbp>
References: <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <20180106183859.1ad9ae37@alans-desktop>
 <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
 <20180107033812.awq3vz4gdkps7tix@ast-mbp>
 <20180107135935.6ecfabd5@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180107135935.6ecfabd5@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 07, 2018 at 01:59:35PM +0000, Alan Cox wrote:
> > which means that POC is relying 64-bit address speculation.
> > In the places coverity found the user supplied value is 32-bit,
> 
> People have 32bit computers as well as 64bit and in some cases 32bit is
> fine for an attack depending where your target is relative to the object.

right. absolutely correct on 32-bit archs.
The question whether truncation to 32-bit is enough to workaround
spectre1 on 64-bit archs.
I hope the researchers can clarify.

> lfence timing is also heavily dependent upon what work has to be done to
> retire previous live instructions. 
> BPF does not normally do a lot of writing so you'd expect the cost to be low.

right. to retire previous loads. Not sure what 'not a lot of writing'
has to do with lfence.

Our XDP based DDOS mostly does reads with few writes for stats into maps,
whereas XDP based load balancer modifies every packet.
XDP is root only, so not relevant in the spectre context. Just clarifying
read vs writes in BPF.
