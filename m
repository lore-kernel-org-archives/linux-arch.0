Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 17 Mar 2005 20:13:29 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Consolidation of asm/unaligned.h
Message-Id: <20050317201329.272de7d5.davem@davemloft.net>
In-Reply-To: <20050318002034.GA31880@twiddle.net>
References: <20050317104744.4be7e550.davem@davemloft.net>
	<Pine.LNX.4.62.0503172255380.8760@numbat.sonytel.be>
	<20050317140316.79210a73.davem@davemloft.net>
	<20050318002034.GA31880@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Richard Henderson <rth@twiddle.net>
Cc: geert@linux-m68k.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 17 Mar 2005 16:20:34 -0800
Richard Henderson <rth@twiddle.net> wrote:

> You do realize that the compiler knows when the target supports unaligned
> loads, and optimizes the __attribute__((packed)) case appropriately?  I'd
> be surprised if *any* target needed a specialized version (indeed, if so,
> I'd consider this a failing in the compiler).

That's a good point.

Less compilation overhead though for the direct pointer deref defines.
