Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: TASK_SIZE is variable.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20050128063908.GA3195@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain>
	 <20050125155239.4bc469e6.davem@davemloft.net>
	 <20050126063627.GA7198@wotan.suse.de>
	 <20050125224112.306cd1ea.davem@davemloft.net>
	 <20050126071359.GD7198@wotan.suse.de> <20050126074306.GE7198@wotan.suse.de>
	 <20050126000117.62fff2a7.akpm@osdl.org>
	 <16889.43580.716149.901314@cargo.ozlabs.ibm.com>
	 <20050128063908.GA3195@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 11:32:02 +0000
Message-Id: <1106911923.6453.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2005-01-28 at 07:39 +0100, Andi Kleen wrote:
> How does this work? The stack is always at the top of address space
> and it will never change anything.

Is that the case? Doesn't ia64 put some extra things required for
emulation (virtual LDT etc?) in the virtual address space above 4GiB,
for 32-bit processes?

> Or did you do this only to optimize 32bit processes on 64bit kernels?
> If yes then the test in TASK_SIZE or MM_VM_SIZE should take care of it
> anyways.

The test in TASK_SIZE gets it wrong as discussed.

-- 
dwmw2
