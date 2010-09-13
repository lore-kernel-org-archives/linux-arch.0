From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] Disallow building with gcc < 3.4
Date: Mon, 13 Sep 2010 22:52:43 +0100
Message-ID: <20100913215243.GA12464@n2100.arm.linux.org.uk>
References: <1284408880-14414-1-git-send-email-hpa@linux.intel.com> <1284408880-14414-2-git-send-email-hpa@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1284408880-14414-2-git-send-email-hpa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Mike Frysinger <vapier@gentoo.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 13, 2010 at 01:14:36PM -0700, H. Peter Anvin wrote:
> Disallow building the generic kernel code with gcc < 3.4.  Earlier
> versions of gcc have known problems, and it appears that anyone who
> genuinely needs gcc 3.x can use gcc 3.4 at this point.
> 
> Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>

Reviewed-by: Russell King <rmk+kernel@arm.linux.org.uk>
