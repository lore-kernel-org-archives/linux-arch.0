Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 14:45:08 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213134508.GA933@elte.hu>
References: <20051213105459.GA9879@elte.hu> <dhowells1134431145@warthog.cambridge.redhat.com> <1036.1134473085@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036.1134473085@warthog.cambridge.redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* David Howells <dhowells@redhat.com> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > >      	init_MUTEX_LOCKED()
> > > 	DECLARE_MUTEX_LOCKED()
> > 
> > please kill these two in the simple mutex implementation - they are a 
> > sign of mutexes used as completions.
> 
> That can be done later. It's not necessary to do it in this particular 
> patch set.

i disagree - it's necessary that we dont build complexities into the 
'simple' mutex type, or the whole game starts again. I.e. the 'owner 
unlocks the mutex' rule must be enforced - which makes 
DECLARE_MUTEX_LOCKED() meaningless.

	Ingo
