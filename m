From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/27] smpboot: Provide a generic method to boot secondary
 processors
Date: Mon, 4 Jun 2012 15:18:56 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1206041513000.3086@ionos>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com> <20120601091008.31979.93586.stgit@srivatsabhat.in.ibm.com> <20120601165113.GA18870@merkur.ravnborg.org> <4FC9424E.9060009@linux.vnet.ibm.com> <alpine.LFD.2.02.1206041228330.3086@ionos>
 <4FCCB31B.6060302@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FCCB31B.6060302@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, Suresh Siddha <suresh.b.siddha@intel.com>, Venkatesh Pallipadi <venki@google.com>
List-Id: linux-arch.vger.kernel.org

On Mon, 4 Jun 2012, Srivatsa S. Bhat wrote:
> On 06/04/2012 04:02 PM, Thomas Gleixner wrote:
> I can add the prototype w/o the __weak prefix and the #ifndef magic in
> include/linux/smpboot.h (which I will, and include it in v2).
> 
> However, I can't get rid of the #ifndef magic in kernel/smpboot.c because
> it will cause build failures on x86.
> 
> I addressed this same issue in another email:
> https://lkml.org/lkml/2012/6/3/33

> In short, to avoid breaking build on x86.
> We wanted to follow the x86 convention of having static inline functions in
> arch/x86/include/asm/smp.h and use the smp_ops structure to route the calls
> to x86 or xen as appropriate (see patch 4 in this series).

Oh no. That's not really a good argument.

There is no reason why this _must_ be an inline function on x86. It
can be a proper function in arch/x86/kernel/smpboot.c as well.

The alternative solution is to generalize the smp_ops approach and get
rid of the weak implementations completely.

Thanks,

	tglx
