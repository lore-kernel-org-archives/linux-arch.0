Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [195.59.15.196] ([195.59.15.196]:59725 "EHLO
	mailapp01.imgtec.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755953AbcANVBb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jan 2016 16:01:31 -0500
Message-ID: <56980C91.1010403@imgtec.com>
Date: Thu, 14 Jan 2016 13:01:05 -0800
From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
MIME-Version: 1.0
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
References: <56945366.2090504@imgtec.com> <20160112092711.GP6344@twins.programming.kicks-ass.net> <20160112102555.GV6373@twins.programming.kicks-ass.net> <20160112104012.GW6373@twins.programming.kicks-ass.net> <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com> <20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com> <20160114203430.GC3818@linux.vnet.ibm.com>
In-Reply-To: <20160114203430.GC3818@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com, james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20160114210105.AKUo8tAJsttr0HF1dKnG9QtemprjNA_wo8hUIHzN5-s@z>

I need some time to understand your test examples. However,

On 01/14/2016 12:34 PM, Paul E. McKenney wrote:
>
>
> The WRC+addr+addr is OK because data dependencies are not required to be
> transitive, in other words, they are not required to flow from one CPU to
> another without the help of an explicit memory barrier.

I don't see any reliable way to fit WRC+addr+addr into "DATA DEPENDENCY 
BARRIERS" section recommendation to have data dependency barrier between 
read of a shared pointer/index and read the shared data based on that 
pointer. If you have this two reads, it doesn't matter the rest of 
scenario, you should put the dependency barrier in code anyway. If you 
don't do it in WRC+addr+addr scenario then after years it can be easily 
changed to different scenario which fits some of scenario in "DATA 
DEPENDENCY BARRIERS" section and fails.

>    Transitivity is

Peter Zijlstra recently wrote: "In particular we're very much all 
'confused' about the various notions of transitivity". I am confused 
too, so - please use some more simple way to explain your words. Sorry, 
but we need a common ground first.

- Leonid.
