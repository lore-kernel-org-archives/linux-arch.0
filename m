From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] bitfield: Use __ffs64(x) to fix missing __ffsdi2()
Date: Mon, 9 Oct 2017 07:34:34 -0700
Message-ID: <20171009073434.0110d4fb@cakuba.netronome.com>
References: <1507538449-22775-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507538449-22775-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, kbuild test robot <fengguang.wu@intel.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon,  9 Oct 2017 10:40:49 +0200, Geert Uytterhoeven wrote:
> On most architectures[*], gcc turns __builtin_ffsll() into a call to
> __ffsdi2(), which is not provided by any architecture, leading to
> failures like:
> 
>     rcar-gen3-cpg.c:(.text+0x289): undefined reference to `__ffsdi2'
> 
> To fix this, use __ffs64() instead, which is available on all
> architectures.
> 
> [*] Known exceptions are some 64-bit architectures like amd64, arm64,
>     ia64, powerpc64, and tilegx.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Fixes: 3e9b3112ec74f192 ("add basic register-field manipulation macros")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
