From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3 [resend] 14/18] smp, x86, xen: kill SMP single
	function call interrupt
Date: Mon, 16 Dec 2013 11:33:34 -0500
Message-ID: <20131216163334.GC20165@phenom.dumpdata.com>
References: <1387125400-28849-1-git-send-email-liuj97@gmail.com>
	<1387125400-28849-15-git-send-email-liuj97@gmail.com>
	<20131216030040.GB7180@pegasus.dumpdata.com>
	<DE8DF0795D48FD4CA783C40EC82923350142ABC2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <DE8DF0795D48FD4CA783C40EC82923350142ABC2@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Liu, Jinsong" <jinsong.liu@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Jiri Kosina <trivial@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Wang YanQing <udknight@gmail.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, David Vrabel <david.vrabel@citrix.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Andrew Morton <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Shaohua Li <shli@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 16, 2013 at 04:24:41AM +0000, Liu, Jinsong wrote:
> Konrad Rzeszutek Wilk wrote:
> > On Mon, Dec 16, 2013 at 12:36:36AM +0800, Jiang Liu wrote:
> >> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> >> similar to smp_call_function_single()" has unified the way to handle
> >> single and multiple cross-CPU function calls. Now only one interrupt
> >> is needed for architecture specific code to support generic SMP
> >> function 
> >> call interfaces, so kill the redundant single function call
> >> interrupt. 
> >> 
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Shaohua Li <shli@kernel.org>
> >> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> >> Cc: Ingo Molnar <mingo@elte.hu>
> >> Cc: Steven Rostedt <rostedt@goodmis.org>
> >> Cc: Jiri Kosina <trivial@kernel.org>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > 
> > I presume this has been tested?
> > 
> 
> I have just test Jiang's patch, it works fine for dom0 booting.

Excellent! Please add Acked-by from me.

Thanks!

> 
> Thanks,
> Jinsong
> 
> 
