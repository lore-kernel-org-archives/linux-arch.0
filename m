Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 5 Feb 2005 15:44:48 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050205154448.1cc89ee9.davem@davemloft.net>
In-Reply-To: <20050205090619.C30866@flint.arm.linux.org.uk>
References: <200502050150.j151osl11380@mail.osdl.org>
	<Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
	<Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org>
	<20050205090619.C30866@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 5 Feb 2005 09:06:19 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

> Except that "addr_limit" may be defined by an architecture to be zero
> (which can be interpreted as 4GB by the arch specific code) for the
> case where we allow kernel mode access.

I believe this to be a problematic scheme, let me explain why.

First, "set_fs(KERNEL_DS)" allows kernel mode access, but it absolutely
must not allow user mode accesses.  It seems to suggest we might need
some "addr_min" value for access_ok() checking purposes...

Also, as I tried to explain in another email today in this thread,
cpu's fall roughly into two categories:

1) Single virtual address range, page table protection (or
   "implicit" protection bits) for address ranges determine
   supervisor vs. user access.  x86_64, x86, MIPS, and Alpha
   I know fall into this category.

2) Really seperate supervisor and user address spaces.
   Which one to get at is specified by an added attribute
   tag given to load and store instructions.  There is an
   implicit tag active at all times which says what a normal
   load/store accesses.  So for example:

	load_word	[%addr] ASI_USER, %reg

   done from supervisor space cannot possibly reference
   supervisor space, for any value of %addr.

On sparc64, which uses the model as in #2, there is an
"%asi" register which holds ASI_* values.  So we just make
set_fs() update this register with either ASI_USER or ASI_KERNEL.
Then for userspace accesses, we use '[%addr] %asi' addressing
in the load/store instructions.

As a result, access_ok() is a complete NOP.  The CPU does all the
work at load/store time.

On platforms using model #1, access_ok() can use some software
state (min_addr/max_addr), which specifies the address where
userspace ends and supervisor virtual addresses begin.
