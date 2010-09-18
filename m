From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Sat, 18 Sep 2010 17:54:37 -0600
Message-ID: <20100918235436.GD25139@parisc-linux.org>
References: <4C95324B.2030707@mcgary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:47962 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab0IRXyj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2010 19:54:39 -0400
Content-Disposition: inline
In-Reply-To: <4C95324B.2030707@mcgary.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg McGary <greg@mcgary.org>
Cc: linux-arch@vger.kernel.org

On Sat, Sep 18, 2010 at 02:42:35PM -0700, Greg McGary wrote:
>  I am porting Linux to a new architecture (a massively multi-threaded network processor), which has a unique and bothersome characteristic: sizeof (void*) > sizeof (long).  In most regards, it is a 32-bit machine, but pointers and all GPRs are 48 bit.  Pointers occupy 64 bits in memory, with 16 bits ignored by load/store.

Linux really only supports ILP32 and LP64 models.  Pick one, and make
your gcc mmtnp-unknown-linux triplet support it.

ILP32 may be a better model for you, depending how much RAM your mmtnp
processor is likely to support.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
