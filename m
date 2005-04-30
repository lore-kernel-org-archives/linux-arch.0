Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [RFC] unify semaphore implementations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <17010.58405.906123.715001@cargo.ozlabs.ibm.com>
References: <20050428182926.GC16545@kvack.org>
	 <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
	 <20050429141437.GA24617@kvack.org>
	 <17010.58405.906123.715001@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 30 Apr 2005 12:50:16 -0400
Message-Id: <1114879817.14213.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On lau , 2005-04-30 at 11:49 +1000, Paul Mackerras wrote:
> Benjamin LaHaise writes:
> 
> > There are at least two users who need asynchronous semaphore/mutex 
> > operations: aio_write (which needs to acquire i_sem), and nfs.  
> 
> What do you mean by asynchronous semaphore/mutex operations?  Are you
> talking about a down operation that will acquire the semaphore if it
> is free, but if not, arrange for a callback and return immediately, or
> something?

Yes. See the iosem patches I posted a couple of weeks ago.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>
