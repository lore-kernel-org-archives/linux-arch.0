Return-Path: <linux-arch-owner@vger.kernel.org>
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17311.22374.434801.753813@gargle.gargle.HOWL>
Date: Wed, 14 Dec 2005 02:21:10 +0300
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <1134479713.11732.25.camel@localhost.localdomain>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<1134479118.11732.14.camel@localhost.localdomain>
	<1134479713.11732.25.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Alan Cox writes:
 > Actually a PS to this while I think about it. spin_locks and mutex type
 > locks could both do with a macro for
 > 
 > 	call_locked(&lock, foo(a,b,c,d))

reiser4 code was publicly humiliated for such macros, but indeed they
are useful. The only problem is that one needs two macros: one for foo()
returning void and one for all other cases.

 > 
 > to cut down on all the error path forgot to release a lock type errors.
 > 

Nikita.
