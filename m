Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 5 Feb 2005 07:54:52 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <20050205065452.GA32565@wotan.suse.de>
References: <200502050150.j151osl11380@mail.osdl.org> <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org, Linux Arch list <linux-arch@vger.kernel.org>, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

> Would arch maintainers please look at fixing this in their architectures 
> instead? Make TASK_SIZE be the maximum size a process VM can have. 

The problem is that compat flexmmap depends on it. I actually dropped flexmmap
again, but the x86-64 flexmmap which will be merged at some point again
had a x86-64 change to switch to variable TASK_SIZE. 

-Andi
