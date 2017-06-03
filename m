From: Christoph Hellwig <hch@lst.de>
Subject: untangle the <asm/siginfo.h> mess
Date: Sat,  3 Jun 2017 21:00:57 +0200
Message-ID: <20170603190102.28866-1-hch@lst.de>
Return-path: <linux-ia64-owner@vger.kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

We currently have uapi versions of <asm/siginfo.h> which at least on a few
architectures define bits of the userspace ABI before including an uapi
asm-generic version, and also non-uapi versions which do almost nothing
except for making sure other headers include the right uapi one before
including an asm-generic that defined two prototypes and a few defines
that aren't architecture specific in any.

This series completely gets rid of the non-uapi versions and cleans up
various small bits on the way.

Note that Thomas has some posix-timers work overlapping with this, so
it might make sense to take these through the tip tree.
