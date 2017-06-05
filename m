From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: is alpha jensen support dead?
Date: Mon, 5 Jun 2017 13:49:36 +0100 (BST)
Message-ID: <alpine.LFD.2.20.1706051347280.29944@eddie.linux-mips.org>
References: <20170521085848.GA14559@lst.de> <20170521181128.GA13376@gherkin.frus.com> <20170522075128.GB2081@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170522075128.GB2081@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Bob Tracy <rct@gherkin.frus.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 22 May 2017, Christoph Hellwig wrote:

> Great!  Still makes me wonder about Jensen, which appears to be
> the only platform that requires a different build than the normal
> generic PCI-enabled kernel.  And I suspect it's pretty much dead
> at this point..

 Jensen is EISA-only, which is likely why support wasn't folded into the 
generic configuration.

  Maciej
