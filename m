Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 31 Jan 2005 20:38:28 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050131193828.GD12102@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050129122321.0cac707c.akpm@osdl.org> <16892.7218.458371.340859@cargo.ozlabs.ibm.com> <20050130110127.GA8441@wotan.suse.de> <16892.52890.354277.754169@cargo.ozlabs.ibm.com> <20050130182353.1a68745c.davem@davemloft.net> <20050131092354.GD19740@wotan.suse.de> <20050131112957.755e5a0c.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131112957.755e5a0c.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, paulus@samba.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jan 31, 2005 at 11:29:57AM -0800, David S. Miller wrote:
> On Mon, 31 Jan 2005 10:23:54 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > > However, I like the mm->max_addr idea because that could be used
> > > for the mmap()/munmap()/mremap() sanity checks as well instead of
> > > bogus TASK_SIZE.
> > 
> > Hmm, but in process context it is not bogus is it? 
> 
> I guess you're suggesting that there could be times when
> mm->max_addr and the current thread's address space disposition
> are out of sync?

No, i just think it's overkill for the simple task Paul wants
it for. And in mmap/munmap you can just trust what TASK_SIZE
tells you because it's in the correct process context.

-Andi
