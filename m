Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <439EDC3D.5040808@nortel.com>
Date: Tue, 13 Dec 2005 08:35:41 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134479118.11732.14.camel@localhost.localdomain>  <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com>
In-Reply-To: <3874.1134480759@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>>It seems to me it would be far far saner to define something like
>>
>>	sleep_lock(&foo)
>>	sleep_unlock(&foo)
>>	sleep_trylock(&foo)
> 
> Which would be a _lot_ more work. It would involve about ten times as many
> changes, I think, and thus be more prone to errors.

"lots of work" has never been a valid reason for not doing a kernel 
change...

In this case, introducing a new API means the changes can be made over time.

As time goes on you can convert more and more code to the mutex/sleep 
lock and any tricky code just stays with the older API until someone who 
understands it can vet it.

As Alan mentioned, the standard counting semaphore API is up/down. 
Making those refer to a sleeping mutex violates the principle of least 
surprise.

Chris
