Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 4 Feb 2005 23:18:16 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050204231816.76b989a6.akpm@osdl.org>
In-Reply-To: <20050205065452.GA32565@wotan.suse.de>
References: <200502050150.j151osl11380@mail.osdl.org>
	<Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
	<20050205065452.GA32565@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen <ak@suse.de> wrote:
>
> > Would arch maintainers please look at fixing this in their architectures 
>  > instead? Make TASK_SIZE be the maximum size a process VM can have. 
> 
>  The problem is that compat flexmmap depends on it. I actually dropped flexmmap
>  again, but the x86-64 flexmmap which will be merged at some point again
>  had a x86-64 change to switch to variable TASK_SIZE. 

TASK_SIZE is a property of the mm_struct, is it not?  Why can't add
mm_struct.task_size and kill off TASK_SIZE altogether?  And MM_VM_SIZE?

Stuff like ia64's

	#define TASK_SIZE		(current->thread.task_size)

just seems dead wrong to me, in the case where a random /proc reader is the
last one left holding a reference to the mm.

Paul's patch seems disjoint from the above - it adds task_size.max_addr
which records the highest virtual address which the mm has mapped.  Nice
for optimising various teardown things, but not suitable for TASK_SIZE
elimination.
