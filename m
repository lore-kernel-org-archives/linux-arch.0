Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 5 Feb 2005 15:27:52 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050205152752.671e7a72.davem@davemloft.net>
In-Reply-To: <20050205074025.GA23814@wotan.suse.de>
References: <200502050150.j151osl11380@mail.osdl.org>
	<Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
	<20050205065452.GA32565@wotan.suse.de>
	<20050204231816.76b989a6.akpm@osdl.org>
	<20050205074025.GA23814@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, torvalds@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

On Sat, 5 Feb 2005 08:40:25 +0100
Andi Kleen <ak@suse.de> wrote:

> I wouldn't combine it with set_fs like Linus proposed though, because
> that could lead to mistakes in set_fs(KERNEL_DS)

That's a good point.

However, from another perspective it does make some sense.
I only know of a cpu type or two that really provide strong
address space protection for accidental supervisor mode accesses
to user space.  I know sparc64 provides this for sure, and I
think parisc has something similar as well.

Andi is very familiar with this, because some compat layer
code written and tested on x86_64 fails on sparc64 because the
latter disallows the following:

extern int sys_foo(const char __user *buf, unsigned long __user *ret_val);

int compat_sys_foo(compat_uptr_t u_buf, compat_uptr_t u_ret_val)
{
	const char __user *buf = compat_ptr(u_buf);
	unsigned long k_val;
	mm_segment_t old_fs = get_fs();
	int err;

	set_fs(KERNEL_DS);
	err = sys_foo(buf, (unsigned long __user *) &k_val);
 ...

This does not fault on x86_64, but it does on platforms like sparc64.
Even though it doesn't fault on x86_64, it's a security hole because it
allows the user to pass in kernel addresses, and such kernel addresses
will just work since we're in KERNEL_DS.

If set_fs() updated some mm->max_addr thing, access_ok() and friends
would trap things like this in software even on x86_64.  Therefore,
I think if anything it's a very good bug check.
