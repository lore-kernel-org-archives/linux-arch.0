From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 00/13] mm: remove __ARCH_HAS_5LEVEL_HACK
Date: Sun, 16 Feb 2020 08:22:30 +0000
Message-ID: <20200216082230.GV25745@shell.armlinux.org.uk>
References: <20200216081843.28670-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200216081843.28670-1-rppt@kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Guan Xuetao <gxt@pku.edu.cn>, James Morse <james.morse@arm.com>, Jonas Bonn <jonas@southpole.se>, Julien Thierry <julien.thierry.kdev@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Rich Felker <dalias@libc.org>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kr>
List-Id: linux-arch.vger.kernel.org

On Sun, Feb 16, 2020 at 10:18:30AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> These patches convert several architectures to use page table folding and
> remove __ARCH_HAS_5LEVEL_HACK along with include/asm-generic/5level-fixup.h.
> 
> The changes are mostly about mechanical replacement of pgd accessors with p4d
> ones and the addition of higher levels to page table traversals.
> 
> All the patches were sent separately to the respective arch lists and
> maintainers hence the "v2" prefix.

You fail to explain why this change which adds 488 additional lines of
code is desirable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
