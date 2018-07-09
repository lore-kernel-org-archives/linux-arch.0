From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and
 alignment
Date: Mon, 9 Jul 2018 16:45:46 +0200
Message-ID: <20180709144546.GT2476@hirez.programming.kicks-ass.net>
References: <20180709124741.21037-1-abrodkin@synopsys.com>
 <20180709133542.GP2476@hirez.programming.kicks-ass.net>
 <6762443004f96d279cba77b7c412163769c930fe.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6762443004f96d279cba77b7c412163769c930fe.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "josh@joshtriplett.org" <josh@joshtriplett.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "tglx@linutronix.de" <tglx@linutronix.de>, "dvhart@infradead.org" <dvhart@infradead.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, "mingo@redhat.com" <mingo@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>, arn
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 09, 2018 at 02:30:41PM +0000, Alexey Brodkin wrote:
> Hm, any thoughts on why it's "u64" for 32-bit x86?

Accident probably. It probably doesn't really matter all that much
because the kernel hard assumes 2s complement, but it is somewhat
inconsistent.
