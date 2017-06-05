Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:33954 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdFEMto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jun 2017 08:49:44 -0400
Date: Mon, 5 Jun 2017 13:49:36 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: is alpha jensen support dead?
In-Reply-To: <20170522075128.GB2081@lst.de>
Message-ID: <alpine.LFD.2.20.1706051347280.29944@eddie.linux-mips.org>
References: <20170521085848.GA14559@lst.de> <20170521181128.GA13376@gherkin.frus.com> <20170522075128.GB2081@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bob Tracy <rct@gherkin.frus.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20170605124936.c8yOp-g0a_VwPQR3pgxq4MOCpWXyOFi3ObWYsL0liRk@z>

On Mon, 22 May 2017, Christoph Hellwig wrote:

> Great!  Still makes me wonder about Jensen, which appears to be
> the only platform that requires a different build than the normal
> generic PCI-enabled kernel.  And I suspect it's pretty much dead
> at this point..

 Jensen is EISA-only, which is likely why support wasn't folded into the 
generic configuration.

  Maciej
