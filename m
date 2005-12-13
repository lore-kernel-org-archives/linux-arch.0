Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20051213131312.GJ9286@parisc-linux.org>
References: <439E122E.3080902@yahoo.com.au> <20051213101300.GA2178@elte.hu>
	 <20051213103420.GA6681@elte.hu> <200512131347.30464.oliver@neukum.org>
	 <1134479371.11732.19.camel@localhost.localdomain>
	 <20051213131312.GJ9286@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 14:04:06 +0000
Message-Id: <1134482647.11732.35.camel@localhost.localdomain>
Mime-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
Cc: Oliver Neukum <oliver@neukum.org>, Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Maw, 2005-12-13 at 06:13 -0700, Matthew Wilcox wrote:
> > Some platforms already do this for certain sets of operations like
> > atomic_t. The downside however is that you no longer control the lock
> > contention or cache line bouncing. It becomes a question of luck rather
> > than science as to how well it scales.
> 
> s/luck/statistics/

Unfortunately not always. Statistical probability models generally
assume that samples are independent, as does just growing the hash
table. If there are correlations then how those correlations and the
hash function interact isn't simple statistics so growing the hash might
not work as well as would be hoped.

A second problem with the hash is it makes priority inversions
entertaining and unpredictable when using Ingo's -rt work. That isn't a
big problem with the atomic_t stuff in the parisc tree because atomic_t
is effectively the top of the lock ordering for the system.

Growing the hash while it may improve the behaviour isn't going to work
as well as embedding the lock in the object.

Alan
