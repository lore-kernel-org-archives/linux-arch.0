Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:50343 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264960AbUF1OLa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Jun 2004 10:11:30 -0400
Subject: Re: Fw: [SPARC64]: No longer set WANT_PAGE_VIRTUAL.
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20040628025222.1d11f71b.akpm@osdl.org>
References: <20040628025222.1d11f71b.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 28 Jun 2004 09:11:26 -0500
Message-Id: <1088431888.2004.1.camel@mulgrave>
Mime-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2004-06-28 at 04:52, Andrew Morton wrote:
> 
> ChangeSet 1.1768.1.1, 2004/06/27 14:20:23-07:00, davem@nuts.davemloft.net
> 
> 	[SPARC64]: No longer set WANT_PAGE_VIRTUAL.
> 	
> 
> That leasve m68k and mips as the only architectures requesting page->virtual.
> 
> Do they really need it?

Could we leave this in...I'm planning an extenstion to parisc that
requires this.  It looks like, in order to accommodate the pa8800
processor which forbids inequivalent cache lines (aliasing) we're going
to have to move to a fully virtually mapped kernel (as opposed to the
current offset mapped one).

James
