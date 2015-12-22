From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Query about merging memblock and bootmem into one new alloc
Date: Tue, 22 Dec 2015 10:47:47 +0100
Message-ID: <20151222094747.GA25114@ravnborg.org>
References: <CANDtUrciap2iHDWpB4SWwACJaUPaLRP4nFb9u9j1=iCJTiuK8Q@mail.gmail.com>
 <567835B4.3090101@redhat.com>
 <201512212301.02148.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201512212301.02148.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Laura Abbott <labbott@redhat.com>, Sumit Gupta <sumit.g.007@gmail.com>, inux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 21, 2015 at 11:01:01PM +0100, Arnd Bergmann wrote:
> On Monday 21 December 2015, Laura Abbott wrote:
> > ARM no longer uses bootmem, just memblock (see 84f452b1e8fc73ac0e31254c66e3e2260ce5263d
> > ARM: mm: Remove bootmem code and switch to NO_BOOTMEM). Any bootmem calls
> > just go to mm/nobootmem.c which is a wrapper around memblock for compatibility.
> 
> It seems the same is true on arc, arm64, powerpc, s390, sparc, tile and x86,
> and we'd ideally move all others the same way.

Small detail - sparc64 uses memblock, whereas sparc32 uses bootmem.

I know because I once tried to move sparc32 to use memblock, but
ran out of time.

	Sam
