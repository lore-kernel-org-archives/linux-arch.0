Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 3 Feb 2005 08:19:13 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050203071913.GB29367@wotan.suse.de>
References: <16892.7218.458371.340859@cargo.ozlabs.ibm.com> <20050130110127.GA8441@wotan.suse.de> <16892.52890.354277.754169@cargo.ozlabs.ibm.com> <20050130182353.1a68745c.davem@davemloft.net> <20050131092354.GD19740@wotan.suse.de> <20050131112957.755e5a0c.davem@davemloft.net> <20050131193828.GD12102@wotan.suse.de> <20050131123550.2dbe41e2.davem@davemloft.net> <20050202200812.100aedca.akpm@osdl.org> <20050202222841.5e380e03.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202222841.5e380e03.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, paulus@samba.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Feb 02, 2005 at 10:28:41PM -0800, David S. Miller wrote:
> On Wed, 2 Feb 2005 20:08:12 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Guys, I still don't have a clear sense of what you want done on this front.
> > I'm still sitting on the below two patches.
> > 
> > If 2.6.11-rc3 works correctly as-is then let's leave it alone.  If it does
> > not then can we please get a wiggle on?
> 
> I'm willing to go whatever way people want to get a fix quickly
> into 2.6.11-final.  But longer term I think the mm->vm_limit idea
> is the better direction longer term.

For 2.6.11 MM_VM_SIZE is imho the right fix. 

-Andi (who reconsidered his earlier objection)
