Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1134479118.11732.14.camel@localhost.localdomain>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 13:15:13 +0000
Message-Id: <1134479713.11732.25.camel@localhost.localdomain>
Mime-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Actually a PS to this while I think about it. spin_locks and mutex type
locks could both do with a macro for

	call_locked(&lock, foo(a,b,c,d))

to cut down on all the error path forgot to release a lock type errors.
