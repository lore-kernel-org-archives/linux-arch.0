From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] new files for score architecture
Date: Mon, 15 Jun 2009 07:26:28 -0400
Message-ID: <20090615112628.GA26150@infradead.org>
References: <OF45B1D9C0.65F15587-ON482575D6.0010FAAA-482575D6.0012D17F@sunplusct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:53821 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbZFOL0a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2009 07:26:30 -0400
Content-Disposition: inline
In-Reply-To: <OF45B1D9C0.65F15587-ON482575D6.0010FAAA-482575D6.0012D17F@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>

On Mon, Jun 15, 2009 at 11:21:01AM +0800, liqin.chen@sunplusct.com wrote:
> Hi Linus,
> 
> This pack contains initial pack for S+core CPU.
> The patches are reviewed by Arnd and many people.
> Because I have not get the git repository now, 
> So Arnd kindly commit score patch into 
> git/arnd/asm-generic.git.

As mentioned before the ptrace implementation is badly wrong as it's
been copy and pasted from a years old stage of some other architecture
and just munged enough to compile.
