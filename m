Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 26 Jan 2005 09:04:34 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050126080434.GF7198@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050125155239.4bc469e6.davem@davemloft.net> <20050126063627.GA7198@wotan.suse.de> <20050125224112.306cd1ea.davem@davemloft.net> <20050126071359.GD7198@wotan.suse.de> <20050126074306.GE7198@wotan.suse.de> <20050126000117.62fff2a7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126000117.62fff2a7.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, davem@davemloft.net, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jan 26, 2005 at 12:01:17AM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> >  After thinking about it more I agree. Just replacing TASK_SIZE with
> >  something that depends on the mm is the best solution here.
> 
> OK.
> 
> Here's what I currently have:

I suspect more architectures need to be fixed, just doing  ia64/s390/ppc64
is not enough. x86-64 is safe in mainline, but some people carry
a patch to make TASK_SIZE variable for flex-mmap.

-Andi
