Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 17 Mar 2005 16:20:34 -0800
From: Richard Henderson <rth@twiddle.net>
Subject: Re: Consolidation of asm/unaligned.h
Message-ID: <20050318002034.GA31880@twiddle.net>
References: <20050317104744.4be7e550.davem@davemloft.net> <Pine.LNX.4.62.0503172255380.8760@numbat.sonytel.be> <20050317140316.79210a73.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317140316.79210a73.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Mar 17, 2005 at 02:03:16PM -0800, David S. Miller wrote:
> Thanks for the info.  I've just added the following diff
> on top so that the COLDFIRE build uses the new generic
> unaligned header.

You do realize that the compiler knows when the target supports unaligned
loads, and optimizes the __attribute__((packed)) case appropriately?  I'd
be surprised if *any* target needed a specialized version (indeed, if so,
I'd consider this a failing in the compiler).


r~
