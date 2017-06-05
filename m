From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] remove non-uapi <asm/siginfo.h>
Date: Mon, 5 Jun 2017 09:18:21 +0200
Message-ID: <20170605071821.GA21343@lst.de>
References: <20170603190102.28866-1-hch@lst.de> <20170603190102.28866-6-hch@lst.de> <alpine.DEB.2.20.1706041510440.2813@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1706041510440.2813@nanos>
Sender: linux-ia64-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
