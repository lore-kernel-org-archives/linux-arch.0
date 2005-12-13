Return-Path: <linux-arch-owner@vger.kernel.org>
From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Date: Tue, 13 Dec 2005 13:47:30 +0100
References: <439E122E.3080902@yahoo.com.au> <20051213101300.GA2178@elte.hu> <20051213103420.GA6681@elte.hu>
In-Reply-To: <20051213103420.GA6681@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131347.30464.oliver@neukum.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Am Dienstag, 13. Dezember 2005 11:34 schrieb Ingo Molnar:

> the cost of a spinlock-based generic_cmpxchg could be significantly 
> reduced by adding a generic_cmpxchg() variant that also includes a 
> 'spinlock pointer' parameter.
> 
> Architectures that do not have the instruction, can use the specified 
> spinlock to do the cmpxchg. This means that there wont be one single 
> global spinlock to emulate cmpxchg, but the mutex's own spinlock can be 
> used for it.

Can't you use the pointer as a hash input?

	Regards
		Oliver
