From: Christoph Hellwig <hch@lst.de>
Subject: Re: is alpha jensen support dead?
Date: Mon, 22 May 2017 09:51:28 +0200
Message-ID: <20170522075128.GB2081@lst.de>
References: <20170521085848.GA14559@lst.de> <20170521181128.GA13376@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46721 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753046AbdEVHva (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 May 2017 03:51:30 -0400
Content-Disposition: inline
In-Reply-To: <20170521181128.GA13376@gherkin.frus.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 21, 2017 at 01:11:28PM -0500, Bob Tracy wrote:
> Speaking for myself, the PWS 433au I've got continues to function
> admirably as my IPv6 gateway.  Debian unstable and experimental updates
> continue to apply and work within the limits of my ability to test them.
> I'm building and running the release candidates and final versions of
> the kernel.org tree with the unstable tool chain.  Recently there was a
> FTBFS due to relocation issues during the final vmlinux link on alpha:
> that has been fixed, and what's left of the alpha community is pretty
> quick to respond and identify what's going on.
> 
> In summary, alpha is still a viable platform for *me*.

Great!  Still makes me wonder about Jensen, which appears to be
the only platform that requires a different build than the normal
generic PCI-enabled kernel.  And I suspect it's pretty much dead
at this point..
