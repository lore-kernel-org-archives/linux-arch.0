Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 31 Jan 2005 12:35:50 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: TASK_SIZE is variable.
Message-Id: <20050131123550.2dbe41e2.davem@davemloft.net>
In-Reply-To: <20050131193828.GD12102@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain>
	<20050129122321.0cac707c.akpm@osdl.org>
	<16892.7218.458371.340859@cargo.ozlabs.ibm.com>
	<20050130110127.GA8441@wotan.suse.de>
	<16892.52890.354277.754169@cargo.ozlabs.ibm.com>
	<20050130182353.1a68745c.davem@davemloft.net>
	<20050131092354.GD19740@wotan.suse.de>
	<20050131112957.755e5a0c.davem@davemloft.net>
	<20050131193828.GD12102@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: paulus@samba.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 31 Jan 2005 20:38:28 +0100
Andi Kleen <ak@suse.de> wrote:

> No, i just think it's overkill for the simple task Paul wants
> it for. And in mmap/munmap you can just trust what TASK_SIZE
> tells you because it's in the correct process context.

Lots of 64-bit platforms use a constant TASK_SIZE.
This is why such platforms use compat syscall wrappers
to validate mmap args.

I'm saying that if we move over to useing mm->map_limit
in the syscall validation checks, such schemes would no
longer be necessary.

The arity of the address space really is an MM attribute
even though it is inherited from the thread.  The delayed
MM final release bug case via procfs is instrumental in
demonstrating this fact.
