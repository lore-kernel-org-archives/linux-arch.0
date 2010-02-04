From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/6] improve sys_personality for compat architectures
Date: Thu, 4 Feb 2010 17:00:57 +0100
Message-ID: <20100204160057.GA5120@lst.de>
References: <201002021536.51928.arnd@arndb.de> <20100203.091309.52886984.davem@davemloft.net> <4B69D6BA.4030704@zytor.com> <201002040838.10783.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:37038 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932422Ab0BDQCe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 4 Feb 2010 11:02:34 -0500
Content-Disposition: inline
In-Reply-To: <201002040838.10783.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, hch@lst.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tony.luck@intel.com, ralf@linux-mips.org, kyle@mcmartin.ca, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tglx@linutronix.de, mingo@redhat.com, viro@zeniv.linux.org.uk

On Thu, Feb 04, 2010 at 08:38:10AM +0100, Arnd Bergmann wrote:
> I think it would be better to have a consistent behavior across
> architectures, so /something/ should be changed. On x86, the unused
> sys32_personality function can probable just be removed, if nothing
> else.
> 
> If we can get everyone to agree with the x86 way of handling this,
> we can also remove all the special cases for sys32_personality in the
> other architectures.

Yes, this should be common over architectures.  Anyway, I expect there
to be some discussion until we've reached that point, so for now I'll
rebase patches 5 and 6 to not require this patch, and will send one
to kill the unused x86 implementation.  Whatever is the final outcome
can be implemented on top.
