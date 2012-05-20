From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/4] [-next] Makefile: Do not call cc-option before
	including the arch's Makefile
Date: Sun, 20 May 2012 11:27:44 +0200
Message-ID: <20120520092744.GA21341@merkur.ravnborg.org>
References: <1336855148-18817-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336855148-18817-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, May 12, 2012 at 10:39:05PM +0200, Geert Uytterhoeven wrote:
> On architectures that setup CROSS_COMPILE in their arch/*/Makefile
> (blackfin, h8300, m68k, mips, parisc, score, sh, tile, unicore32, xtensa),
> cc-option may check against the wrong compiler, causing errors like
> 
> cc1: error: unrecognized command line option "-fno-ipa-cp-clone"
> 
> if the host gcc supports -fno-ipa-cp-clone, while the cross compiler
> doesn't support that option.
> 
> Move the CONFIG_READABLE_ASM section below the inclusion of the arch's
> Makefile to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: linux-kbuild@vger.kernel.org

Michal - was this serie ever applied to kbuild?

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
