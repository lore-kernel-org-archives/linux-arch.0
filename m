Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <43A3C461.2030900@yahoo.com.au>
Date: Sat, 17 Dec 2005 18:55:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
References: <dhowells1134774786@warthog.cambridge.redhat.com>	 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com> <1134791914.13138.167.camel@localhost.localdomain>
In-Reply-To: <1134791914.13138.167.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@osdl.org, torvalds@osdl.org
List-ID: <linux-arch.vger.kernel.org>

Steven Rostedt wrote:
> On Fri, 2005-12-16 at 23:13 +0000, David Howells wrote:

>>This patch set does the following:
>>
>> (1) Renames DECLARE_MUTEX and DECLARE_MUTEX_LOCKED to be DECLARE_SEM_MUTEX and
>>     DECLARE_SEM_MUTEX_LOCKED for counting semaphores.
>>
> 
> 
> Could we really get rid of that "MUTEX" part.  A counting semaphore is
> _not_ a mutex, although a mutex _is_ a counting semaphore.  As is a Jack
> Russell is a dog, but a dog is not a Jack Russell.
> 

Really?

A Jack Russell is a dog because anything you say about a dog can
also be said about a Jack Russell.

A counting semaphore is a mutex for the same reason (and observe
that 99% of users use the semaphore as a mutex). A mutex definitely
is not a counting semaphore. David's implementation of mutexes
don't count at all.

If you want to use a semaphore as a mutex, DECLARE_SEM_MUTEX isn't
a terrible name.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
