Return-Path: <linux-arch-owner@vger.kernel.org>
From: Andi Kleen <ak@suse.de>
Subject: Re: Kill HAVE_DEC_LOCK
Date: Tue, 13 Sep 2005 08:51:16 +0200
References: <20050912.160503.93067051.davem@davemloft.net> <200509130815.51050.ak@suse.de> <20050912.234700.88643507.davem@davemloft.net>
In-Reply-To: <20050912.234700.88643507.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509130851.16806.ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 13 September 2005 08:47, David S. Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: Tue, 13 Sep 2005 08:15:50 +0200
>
> > Looks good.  Unfortunately XADD cannot be used for that.
>
> If that were possible, what would be the advantage
> compared to cmpxchg{b,w,l}?

(lock xadd = essentially atomic add and return result) 

It would tell the microcode exactly what we want to do so it
might optimize better. I don't know if it actually works better
on current micro architectures, but it might.

The problem is that it cannot do the spinlock atomically,
so we have to use cmpxchg anyways.

-Andi
