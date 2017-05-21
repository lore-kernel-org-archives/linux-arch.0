From: Bob Tracy <rct@gherkin.frus.com>
Subject: Re: is alpha jensen support dead?
Date: Sun, 21 May 2017 13:11:28 -0500
Message-ID: <20170521181128.GA13376@gherkin.frus.com>
References: <20170521085848.GA14559@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170521085848.GA14559@lst.de>
Sender: linux-alpha-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, May 21, 2017 at 10:58:48AM +0200, Christoph Hellwig wrote:
> Btw, how well is alpha working these days?  It looks like there hasn't
> been any maintainer activity for about two years.

Speaking for myself, the PWS 433au I've got continues to function
admirably as my IPv6 gateway.  Debian unstable and experimental updates
continue to apply and work within the limits of my ability to test them.
I'm building and running the release candidates and final versions of
the kernel.org tree with the unstable tool chain.  Recently there was a
FTBFS due to relocation issues during the final vmlinux link on alpha:
that has been fixed, and what's left of the alpha community is pretty
quick to respond and identify what's going on.

In summary, alpha is still a viable platform for *me*.

--Bob
