Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17010.58405.906123.715001@cargo.ozlabs.ibm.com>
Date: Sat, 30 Apr 2005 11:49:25 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] unify semaphore implementations
In-Reply-To: <20050429141437.GA24617@kvack.org>
References: <20050428182926.GC16545@kvack.org>
	<17009.33633.378204.859486@cargo.ozlabs.ibm.com>
	<20050429141437.GA24617@kvack.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Benjamin LaHaise writes:

> There are at least two users who need asynchronous semaphore/mutex 
> operations: aio_write (which needs to acquire i_sem), and nfs.  

What do you mean by asynchronous semaphore/mutex operations?  Are you
talking about a down operation that will acquire the semaphore if it
is free, but if not, arrange for a callback and return immediately, or
something?

Paul.
