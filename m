Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 31 Jan 2005 10:23:54 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050131092354.GD19740@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050129122321.0cac707c.akpm@osdl.org> <16892.7218.458371.340859@cargo.ozlabs.ibm.com> <20050130110127.GA8441@wotan.suse.de> <16892.52890.354277.754169@cargo.ozlabs.ibm.com> <20050130182353.1a68745c.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130182353.1a68745c.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Paul Mackerras <paulus@samba.org>, ak@suse.de, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> However, I like the mm->max_addr idea because that could be used
> for the mmap()/munmap()/mremap() sanity checks as well instead of
> bogus TASK_SIZE.

Hmm, but in process context it is not bogus is it? 

-Andi
