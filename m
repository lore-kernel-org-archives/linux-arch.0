Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 26 Jan 2005 08:13:59 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050126071359.GD7198@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050125155239.4bc469e6.davem@davemloft.net> <20050126063627.GA7198@wotan.suse.de> <20050125224112.306cd1ea.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125224112.306cd1ea.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> I just checked and ia64 sets thread.task_size in SET_PERSONALITY()
> which is just fine, similarly for ppc64.  So I really wonder how
> this problem can arise.

After rereading Anton's post on l-k I think the problem happens
when a proc accesses (like read on /proc/*/cmdline) increases the 
reference count of a mm, then the mm exits, and then the other
process reading /proc does the final mmput. Then the exit_mmap
executes in the context of the other process. 

Maybe it would be best to just use a semaphore to synchronize
this? 

[BTW there seem to be some other issues in this code; I'm currently
together with someone else trying to track down a exit mm race that causes 
machine checks on K8 because an lazy mm task has page tables that are already
freed and get overwritten by random data. Still haven't root caused it yet]

-Andi
