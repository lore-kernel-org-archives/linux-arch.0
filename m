Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 5 Feb 2005 08:40:25 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <20050205074025.GA23814@wotan.suse.de>
References: <200502050150.j151osl11380@mail.osdl.org> <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org> <20050205065452.GA32565@wotan.suse.de> <20050204231816.76b989a6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204231816.76b989a6.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

On Fri, Feb 04, 2005 at 11:18:16PM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > > Would arch maintainers please look at fixing this in their architectures 
> >  > instead? Make TASK_SIZE be the maximum size a process VM can have. 
> > 
> >  The problem is that compat flexmmap depends on it. I actually dropped flexmmap
> >  again, but the x86-64 flexmmap which will be merged at some point again
> >  had a x86-64 change to switch to variable TASK_SIZE. 
> 
> TASK_SIZE is a property of the mm_struct, is it not?  Why can't add
> mm_struct.task_size and kill off TASK_SIZE altogether?  And MM_VM_SIZE?

Probably yes.

I wouldn't combine it with set_fs like Linus proposed though, because
that could lead to mistakes in set_fs(KERNEL_DS)

-Andi
