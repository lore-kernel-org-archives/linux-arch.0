Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 28 Apr 2005 11:53:44 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC] unify semaphore implementations
Message-Id: <20050428115344.4e10a7f4.davem@davemloft.net>
In-Reply-To: <20050428185956.GD16545@kvack.org>
References: <20050428182926.GC16545@kvack.org>
	<1114714089.5022.3.camel@mulgrave>
	<20050428185956.GD16545@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: James.Bottomley@steeleye.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 28 Apr 2005 14:59:56 -0400
Benjamin LaHaise <bcrl@kvack.org> wrote:

> On Thu, Apr 28, 2005 at 11:48:09AM -0700, James Bottomley wrote:
> > Could you come up with a less monolithic way to share this so that we
> > can still do a spinlock semaphore implementation instead of an atomic op
> > based one?
> 
> As I read the code, it doesn't make a difference: parisc will take a 
> spin lock within the atomic operation and then release it, which makes 
> the old fast path for the semaphores and the new fast path pretty much 
> equivalent (they both take and release one spinlock).

I think parisc should be allowed to choose their implementation of
semaphores.  Look, if you change semaphores in some way it will
be their problem to keep their parisc version in sync.

Or you could provide both a spinlocked and an atomic op based implementation
of generic semaphores, as we do for rwsem already.
