Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 17 Jun 2005 10:50:29 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: Global spinlock vs local bit spin locks
Message-ID: <20050617085029.GJ31127@wotan.suse.de>
References: <1118982092.5261.44.camel@npiggin-nld.site> <20050616214518.7df96d8a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616214518.7df96d8a.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, davem@davemloft.net, anton@samba.org, linux-arch@vger.kernel.org, Peter.Keilty@hp.com
List-ID: <linux-arch.vger.kernel.org>

> The reason why I went with a hashed lock is that I have memories of being
> beaten up over suckiness of bit_spin_lock().  But I'm now wondering who was
> beating me up, and why ;)

At least on x86/x86-64 I see no reason to not use them.

-Andi
