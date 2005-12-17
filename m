Return-Path: <linux-arch-owner@vger.kernel.org>
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Date: Fri, 16 Dec 2005 16:41:49 -0800
References: <Pine.LNX.4.64.0512160829180.3060@g5.osdl.org> <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org> <20051216.145306.132052494.davem@davemloft.net>
In-Reply-To: <20051216.145306.132052494.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161641.49571.jbarnes@virtuousgeek.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, dhowells@redhat.com, nickpiggin@yahoo.com.au, arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Friday, December 16, 2005 2:53 pm, David S. Miller wrote:
> When the write comes along, the next transaction occurs to kick it
> out the other cpu(s) caches and then the local line is placed into
> Owned state.
>
> I'll have to add "put write prefetch in CAS sequences" onto my sparc64
> TODO list :-)

Note that under contention prefetching with a write bias can cause a lot 
more cache line bouncing than a regular load into shared state (assuming 
you do a load and test before you try the CAS).  We actually saw this on 
large Altix machines, 
http://lia64.bkbits.net:8080/to-linus-2.5/cset%403f2082b3xCvMG9OSeNu3aWhoe6jnOg?nav=index.html|
src/.|src/include|src/include/asm-ia64|
related/include/asm-ia64/spinlock.h fixed things up for us.

Jesse
