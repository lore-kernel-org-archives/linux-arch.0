Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 4 Apr 2005 11:47:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Consolidation of asm/unaligned.h
Message-ID: <20050404104702.GE6016@linux-mips.org>
References: <20050317104744.4be7e550.davem@davemloft.net> <1112586161.7087.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112586161.7087.3.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Apr 03, 2005 at 10:42:41PM -0500, James Bottomley wrote:

> I just got around to checking this on parisc, and I'm afraid we have a
> toolchain cockup:  Our gcc can't optimise the sizeof() if the user is an
> inline function.  It can, however if the functions are made #defines
> instead.
> 
> Would the attached be OK with everyone?  It works fine for us.

This started happening occasionally with gcc 3.4 so it's not just PARISC
specific - just rather hard to hit:

  http://www.linux-mips.org/archives/linux-mips/2004-10/msg00039.html

  Ralf
