Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 3 Apr 2005 23:11:00 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Consolidation of asm/unaligned.h
Message-Id: <20050403231100.4c15f6b1.davem@davemloft.net>
In-Reply-To: <1112588136.7087.17.camel@mulgrave>
References: <20050317104744.4be7e550.davem@davemloft.net>
	<1112586161.7087.3.camel@mulgrave>
	<20050403210201.6ecd41aa.davem@davemloft.net>
	<1112588136.7087.17.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 03 Apr 2005 23:15:36 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> Actually, Matthew Wilcox suggested an alternative:  If the inline
> function arguments for the size are consts, then the compiler seems to
> behave correctly, so how about the attached?

That looks perfectly reasonable.

BTW, the second hunk isn't needed in Linus's current tree
which has that include fix already :-)
