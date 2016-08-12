From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Fri, 12 Aug 2016 13:33:14 +0100
Message-ID: <20160812123314.GX1041@n2100.armlinux.org.uk>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, Julian Brown <julian@codesourcery.com>, Alan Modra <amodra@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 12, 2016 at 06:19:17PM +1000, Nicholas Piggin wrote:
> This patch adds an option which defaults to "y" in cases where we
> could possibly be running Cortex A8 and using Thumb2 instructions.
> In reality the workaround might not be required at all for the kernel
> if virtual instruction memory is linear in physical memory.

Hmm.

The main kernel image is guaranteed to be contiguous in physical memory
for all sorts of reasons, so this really isn't a concern for the kernel
itself.

Modules, however, are a different matter, as they are mapped in using
individual pages, and are most likely to be non-contiguous in physical
memory.  The kernel's module linker knows nothing about this errata,
so it'll generally just fix up the relocations in the most basic of
ways.

So, I think we should always use this --no-fix-cortex-a8 option where
the linker supports it irrespective of whether we're running on a core
needing this workaround, but we probably need to fix the kernel module
linker to know about this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
