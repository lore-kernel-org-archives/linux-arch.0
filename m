Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:38445 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdFEHSY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Jun 2017 03:18:24 -0400
Date: Mon, 5 Jun 2017 09:18:21 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] remove non-uapi <asm/siginfo.h>
Message-ID: <20170605071821.GA21343@lst.de>
References: <20170603190102.28866-1-hch@lst.de> <20170603190102.28866-6-hch@lst.de> <alpine.DEB.2.20.1706041510440.2813@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1706041510440.2813@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20170605071821.CStZBt9hmd1bC7C9obWWkWfqZ2Bo2kgYq3QAKXYyiXM@z>

On Sun, Jun 04, 2017 at 03:13:11PM +0200, Thomas Gleixner wrote:
> On Sat, 3 Jun 2017, Christoph Hellwig wrote:
> 
> > By moving the kernel side __SI_* defintions right next to the userspace
> > ones we can kill the non-uapi versions of <asm/siginfo.h> include
> > include/asm-generic/siginfo.h and untangle the unholy mess of includes.
> 
> That needs a couple of fixups and we can remove
> 
> arch/X/include/uapi/asm/siginfo.h from m32r, microblaze, mn10300 and score.
> 
> Delta patch below.

Thanks.  I'm going to include this if I have to resend for some reason.
