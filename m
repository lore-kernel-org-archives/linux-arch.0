Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051213105459.GA9879@elte.hu> 
References: <20051213105459.GA9879@elte.hu>  <dhowells1134431145@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Tue, 13 Dec 2005 11:24:45 +0000
Message-ID: <1036.1134473085@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Ingo Molnar <mingo@elte.hu> wrote:

> >      	init_MUTEX_LOCKED()
> > 	DECLARE_MUTEX_LOCKED()
> 
> please kill these two in the simple mutex implementation - they are a 
> sign of mutexes used as completions.

That can be done later. It's not necessary to do it in this particular patch
set.

David
