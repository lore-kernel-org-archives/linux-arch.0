From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Mon, 8 Jan 2018 10:57:02 +0100
Message-ID: <20180108095702.GE3040@hirez.programming.kicks-ass.net>
References: <20180106183859.1ad9ae37@alans-desktop>
 <20180106185134.dzn2en4vw2hj3p6h@ast-mbp>
 <20180106195551.3207f75d@alans-desktop>
 <20180106200912.zhzdt4qmfrojeeqe@ast-mbp>
 <20180106202213.23e553fb@alans-desktop>
 <20180106211729.cp5oet3at3hyce4o@ast-mbp>
 <20180106230507.3547c9a0@alans-desktop>
 <20180107033812.awq3vz4gdkps7tix@ast-mbp>
 <20180107135935.6ecfabd5@alans-desktop>
 <20180108025732.2mnqgqivnh5u5mfb@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108025732.2mnqgqivnh5u5mfb@ast-mbp>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 07, 2018 at 06:57:35PM -0800, Alexei Starovoitov wrote:
> On Sun, Jan 07, 2018 at 01:59:35PM +0000, Alan Cox wrote:

> > lfence timing is also heavily dependent upon what work has to be done to
> > retire previous live instructions. 
> > BPF does not normally do a lot of writing so you'd expect the cost to be low.
> 
> right. to retire previous loads. Not sure what 'not a lot of writing'
> has to do with lfence.

LFENCE will wait for completion on _ALL_ prior instructions, not just
loads.

Stores are by far the most expensive instructions to wait for, as they
only complete once their value is globally visible (on x86).
