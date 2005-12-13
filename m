Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 06:13:12 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213131312.GJ9286@parisc-linux.org>
References: <439E122E.3080902@yahoo.com.au> <20051213101300.GA2178@elte.hu> <20051213103420.GA6681@elte.hu> <200512131347.30464.oliver@neukum.org> <1134479371.11732.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134479371.11732.19.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver Neukum <oliver@neukum.org>, Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Dec 13, 2005 at 01:09:31PM +0000, Alan Cox wrote:
> On Maw, 2005-12-13 at 13:47 +0100, Oliver Neukum wrote:
> > Can't you use the pointer as a hash input?
> 
> Some platforms already do this for certain sets of operations like
> atomic_t. The downside however is that you no longer control the lock
> contention or cache line bouncing. It becomes a question of luck rather
> than science as to how well it scales.

s/luck/statistics/

You can always increase the size of the hash table if you encounter
scaling problems.
