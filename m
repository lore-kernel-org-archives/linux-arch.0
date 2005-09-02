Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 02 Sep 2005 00:39:40 -0700 (PDT)
Message-Id: <20050902.003940.68050984.davem@davemloft.net>
Subject: Re: [Fwd: [PATCH 2.6.13] lockless pagecache 2/7]
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4317F2FE.8030109@yahoo.com.au>
References: <4317F2FE.8030109@yahoo.com.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: nickpiggin@yahoo.com.au
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Sparc32 lacks compare and exchange.  I think PARISC lacks it
as well.

For these older SMP systems, at best you can assume there
is some kind of spinlock and perhaps a straight atomic
exchange instruction.  You really can't assume the existance
of compare-and-swap.
