Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1134482408.11732.30.camel@localhost.localdomain> 
References: <1134482408.11732.30.camel@localhost.localdomain>  <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Tue, 13 Dec 2005 15:23:34 +0000
Message-ID: <14796.1134487414@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Is there a reason you didnt answer the comment about down/up being the
> usual way computing refers to the operations on counting semaphores but
> just deleted it ?

up/down is also used in conjunction with mutexes and R/W semaphores, so
counting semaphores do not have exclusive rights to the terminology.

David
