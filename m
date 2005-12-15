Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134482408.11732.30.camel@localhost.localdomain>
	<1134479118.11732.14.camel@localhost.localdomain>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<3874.1134480759@warthog.cambridge.redhat.com>
	<14796.1134487414@warthog.cambridge.redhat.com>
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Date: Thu, 15 Dec 2005 14:24:08 +0900
In-Reply-To: <14796.1134487414@warthog.cambridge.redhat.com> (David Howells's message of "Tue, 13 Dec 2005 15:23:34 +0000")
Message-Id: <buo7ja76ih3.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: miles.bader@necel.com
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells <dhowells@redhat.com> writes:
>> Is there a reason you didnt answer the comment about down/up being the
>> usual way computing refers to the operations on counting semaphores but
>> just deleted it ?
>
> up/down is also used in conjunction with mutexes and R/W semaphores, so
> counting semaphores do not have exclusive rights to the terminology.

I suspect that is only the case where the author of the mutex was
accustomed to using semaphores as mutexes before-hand; "up/down" are
rather poor names for mutex operations otherwise.  lock/unlock are much
better.

-Miles
-- 
Next to fried food, the South has suffered most from oratory.
  			-- Walter Hines Page
