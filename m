Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 25 Jan 2005 23:24:41 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: TASK_SIZE is variable.
Message-Id: <20050125232441.6efb49c1.akpm@osdl.org>
In-Reply-To: <20050126071359.GD7198@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain>
	<20050125155239.4bc469e6.davem@davemloft.net>
	<20050126063627.GA7198@wotan.suse.de>
	<20050125224112.306cd1ea.davem@davemloft.net>
	<20050126071359.GD7198@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: davem@davemloft.net, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen <ak@suse.de> wrote:
>
> After rereading Anton's post on l-k I think the problem happens
>  when a proc accesses (like read on /proc/*/cmdline) increases the 
>  reference count of a mm, then the mm exits, and then the other
>  process reading /proc does the final mmput. Then the exit_mmap
>  executes in the context of the other process. 

yup.  This happens in quite a few places.  Everything under mmput() needs
to understand that the mm isn't necessarily current's mm.  I'm not sure
that introcuction of additional locking to prevent that would be very nice.

(Could we null out current->mm during mmput() to catch buggy code, or would
that break the lazy-tlb code?)
