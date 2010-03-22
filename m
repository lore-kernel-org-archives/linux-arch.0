From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 06/20] early_res: seperate common memmap func from e820.c
 to fw_memmap.c
Date: Mon, 22 Mar 2010 14:05:30 +0100
Message-ID: <20100322130530.GC12475@elte.hu>
References: <4BA6EA62.1030603@kernel.org>
 <20100321.210023.209981130.davem@davemloft.net>
 <4BA6F1F6.3070102@kernel.org>
 <20100321.213350.176660494.davem@davemloft.net>
 <20100322092809.GA20607@elte.hu>
 <20100322113026.GA11526@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100322113026.GA11526@brick.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, yinghai@kernel.org, benh@kernel.crashing.org, tglx@linutronix.de, hpa@zytor.com, jbarnes@virtuousgeek.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Paul Mackerras <paulus@samba.org> wrote:

> And I don't see the point of moving the x86 e820 stuff into the kernel 
> directory. [...]

I dont see the point of that either - that is a mistake. e820 is an x86 bios 
call and we shouldnt name a generic mechanism after that. e820 is absolutely 
messy and has no place anywhere beyond x86.

The main technical argument i see is 'early_res versus LMB'. Even there i'd 
prefer LMB from a technical quality POV.

> Well I personally don't mind if x86 uses early_res or whatever other code in 
> arch/x86 to handle the problems that arise from deficient firmware.  I just 
> don't see any value in converting powerpc or sparc64 over to using ~2000 
> lines of early_res/fw_memmap code where the existing ~500 lines of lmb code 
> is working just fine.

Lets put it this way then: do you see any point in PowerPC making use of a 10+ 
million lines of code kernel that is being mainly (80%+) financed, developed, 
tested and deployed by people who care about x86 mostly?

If yes then it seems like a pretty damn good deal to me for PowerPC to go 
beyond its narrow short-term self-interest and work towards generalizations 
more actively, and even consider touching its 500 lines of lmb code ...

I dont know how many times we've accomodated for non-x86 architectures in 
various pieces of kernel code.

Obviously if there's bloat affecting PowerPC then that can be addressed via 
technical measures. But we really shouldnt leave the slightly incompatible 
early allocators in place. (we shouldnt have let them get created in the first 
place, but that is water down the bridge.)

Thanks,

	Ingo
