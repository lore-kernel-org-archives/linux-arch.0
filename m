Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: Consolidation of asm/unaligned.h
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20050404104702.GE6016@linux-mips.org>
References: <20050317104744.4be7e550.davem@davemloft.net>
	 <1112586161.7087.3.camel@mulgrave>  <20050404104702.GE6016@linux-mips.org>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 09:10:54 -0500
Message-Id: <1112710254.5764.8.camel@mulgrave>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2005-04-04 at 11:47 +0100, Ralf Baechle wrote:
> This started happening occasionally with gcc 3.4 so it's not just PARISC
> specific - just rather hard to hit:

Could you verify that the addition of the consts to the inline function
size arguments (previously posted patch) fixes this?  If so, I'll send
the patch on.

James
