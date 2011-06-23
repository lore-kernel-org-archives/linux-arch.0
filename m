From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] STAGING: Comedi: Build only on arches providing
	PAGE_KERNEL_NOCACHE
Date: Thu, 23 Jun 2011 17:31:06 +0100
Message-ID: <20110623163105.GC16892@linux-mips.org>
References: <20110623114536.GA14011@linux-mips.org>
	<BANLkTimR98qo5fjMRf-kZahcA=hE-E3+Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <BANLkTimR98qo5fjMRf-kZahcA=hE-E3+Hg@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devel@driverdev.osuosl.org, linux-m32r-ja@ml.linux-m32r.org, linux-m32r@ml.linux-m32r.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com, Michal Marek <mmarek@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 23, 2011 at 06:01:47PM +0200, Geert Uytterhoeven wrote:

> If only to get m68k/allmodconfig going again (hmm, there's another
> staging driver
> preventing a green light).

I ran into this doing an allyesconfig.  Allyesconfig has one disadvantage,
for choice it will only select the first or default option which means
that option gets exercised well and all the other options not at all.  On
MIPS that'd be IP22, 32-bit, R4x00, big endian, 4K pages, no multithreading,
250Hz.  Make randconfig disables lots of things so often misses the
opportunity to trigger some issues.

I'd really want an "make allrandconfig" which enables as many options as
possible but picks a random one from choice statements, something like that.

  Ralf
