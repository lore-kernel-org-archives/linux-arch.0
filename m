Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 28 Apr 2005 14:59:56 -0400
Sender: Benjamin LaHaise <bcrl@kvack.org>
From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [RFC] unify semaphore implementations
Message-ID: <20050428185956.GD16545@kvack.org>
References: <20050428182926.GC16545@kvack.org> <1114714089.5022.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114714089.5022.3.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Apr 28, 2005 at 11:48:09AM -0700, James Bottomley wrote:
> Could you come up with a less monolithic way to share this so that we
> can still do a spinlock semaphore implementation instead of an atomic op
> based one?

As I read the code, it doesn't make a difference: parisc will take a 
spin lock within the atomic operation and then release it, which makes 
the old fast path for the semaphores and the new fast path pretty much 
equivalent (they both take and release one spinlock).  The only extra 
cost is the address computation for the spinlock.  If there is contention 
for the atomic spinlocks, then parisc can increase the number of buckets 
in their hashed spinlocks.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
