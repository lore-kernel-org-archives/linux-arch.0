Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 7 Feb 2005 12:13:21 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050207121321.3bb6e521.davem@davemloft.net>
In-Reply-To: <20050207201547.GA6790@wotan.suse.de>
References: <20050205090619.C30866@flint.arm.linux.org.uk>
	<20050205154448.1cc89ee9.davem@davemloft.net>
	<20050206105047.GB6819@wotan.suse.de>
	<20050206131947.6524ece9.davem@davemloft.net>
	<20050206213148.GI18245@wotan.suse.de>
	<20050206133110.528ce713.davem@davemloft.net>
	<20050206215020.GJ18245@wotan.suse.de>
	<20050206143110.59dc039f.davem@davemloft.net>
	<20050207081106.GA16035@wotan.suse.de>
	<20050207112837.5594c314.davem@davemloft.net>
	<20050207201547.GA6790@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: rmk@arm.linux.org.uk, torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 7 Feb 2005 21:15:47 +0100
Andi Kleen <ak@suse.de> wrote:

> Yes, but it is done outside KERNEL_DS (otherwise it is a security hole) 
> And then later in KERNEL_DS there is no verify_area.

It is done "inside" KERNEL_DS by the routines we invoke which
expect user pointers but we're giving them kernel pointers.
Example:

extern long sys_foo(char __user *buf, int len);

long compat_sys_foo(compat_uptr_t ubuf, int len)
{
	char *kbuf = kmalloc(len, GFP_KERNEL);
	mm_segment_t old_fs = get_fs();
	int err;

	if (!kbuf)
		return -ENOMEM;

	set_fs(KERNEL_DS);
	err = sys_foo(kbuf, len);
	set_fs(old_fs);

	kfree(kbuf);

	return err;
}

The copy_to_user() or whatever done by sys_foo() will operate within
KERNEL_DS on "kbuf" and thus the access_ok() check done via copy_to_user()
will do the proper checks for us with my proposal of valid virtual address
ranges stored in the mm_struct.
