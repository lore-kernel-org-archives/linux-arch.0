Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: TASK_SIZE is variable.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20050203071913.GB29367@wotan.suse.de>
References: <16892.7218.458371.340859@cargo.ozlabs.ibm.com>
	 <20050130110127.GA8441@wotan.suse.de>
	 <16892.52890.354277.754169@cargo.ozlabs.ibm.com>
	 <20050130182353.1a68745c.davem@davemloft.net>
	 <20050131092354.GD19740@wotan.suse.de>
	 <20050131112957.755e5a0c.davem@davemloft.net>
	 <20050131193828.GD12102@wotan.suse.de>
	 <20050131123550.2dbe41e2.davem@davemloft.net>
	 <20050202200812.100aedca.akpm@osdl.org>
	 <20050202222841.5e380e03.davem@davemloft.net>
	 <20050203071913.GB29367@wotan.suse.de>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 09:23:11 +0000
Message-Id: <1107422592.12383.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>, paulus@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2005-02-03 at 08:19 +0100, Andi Kleen wrote:
> 
> > I'm willing to go whatever way people want to get a fix quickly
> > into 2.6.11-final.  But longer term I think the mm->vm_limit idea
> > is the better direction longer term.
> 
> For 2.6.11 MM_VM_SIZE is imho the right fix. 

Agreed. As Dave says, we can always implement the more cunning ideas
later. Push what you have.

-- 
dwmw2
