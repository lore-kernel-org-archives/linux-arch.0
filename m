Return-Path: <linux-arch-owner@vger.kernel.org>
From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Date: Tue, 13 Dec 2005 14:24:08 +0100
References: <439E122E.3080902@yahoo.com.au> <200512131347.30464.oliver@neukum.org> <1134479371.11732.19.camel@localhost.localdomain>
In-Reply-To: <1134479371.11732.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131424.09522.oliver@neukum.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Am Dienstag, 13. Dezember 2005 14:09 schrieb Alan Cox:
> On Maw, 2005-12-13 at 13:47 +0100, Oliver Neukum wrote:
> > > spinlock to do the cmpxchg. This means that there wont be one single 
> > > global spinlock to emulate cmpxchg, but the mutex's own spinlock can be 
> > > used for it.
> > 
> > Can't you use the pointer as a hash input?
> 
> Some platforms already do this for certain sets of operations like
> atomic_t. The downside however is that you no longer control the lock
> contention or cache line bouncing. It becomes a question of luck rather
> than science as to how well it scales.

On the other hand you don't control cache eviction either, do you?

	Regards
		Oliver
