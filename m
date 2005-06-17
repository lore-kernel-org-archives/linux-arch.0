Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 16 Jun 2005 21:45:18 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: Global spinlock vs local bit spin locks
Message-Id: <20050616214518.7df96d8a.akpm@osdl.org>
In-Reply-To: <1118982092.5261.44.camel@npiggin-nld.site>
References: <1118982092.5261.44.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: davem@davemloft.net, anton@samba.org, linux-arch@vger.kernel.org, Peter.Keilty@hp.com
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Peter Keilty is running into some scalability problems with buffer
>  head based IO. There are a couple of global spinlocks in the buffer
>  completion path, and they're showing up on 16-way IA64 systems.

Well in -mm these spinlocks are hashed and the performance is good.  But
it's a bit dorky.  So we don't _have_ to go with the bit_spin_lock()
approach.  But bit_spin_lock() is nicer.

The reason why I went with a hashed lock is that I have memories of being
beaten up over suckiness of bit_spin_lock().  But I'm now wondering who was
beating me up, and why ;)
