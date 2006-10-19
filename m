Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:24513 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423153AbWJSSXL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Oct 2006 14:23:11 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: dealing with excessive includes
Date: Thu, 19 Oct 2006 20:24:03 +0200
References: <20061017005025.GF29920@ftp.linux.org.uk> <20061018160609.GO29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610192024.03511.agruen@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 18 October 2006 18:32, Linus Torvalds wrote:
> I think ext2 was already fixed to use its own spinlocks for bitmap
> accesses, although it looks like somebody re-introduced "lock_super()"
> there for xattr handling.

I'll send a cleanup patch for that.

Thanks,
Andreas
