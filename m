From: Matthew Wilcox <willy@linux.intel.com>
Subject: Re: fs: dax: do not build on ARC or SH
Date: Mon, 23 Feb 2015 13:40:25 -0500
Message-ID: <20150223184025.GD2780@wil.cx>
References: <5778538.KJ98x3yxkB@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5778538.KJ98x3yxkB@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <willy@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 23, 2015 at 12:29:45PM +0100, Arnd Bergmann wrote:
> The DAX implementation relies on the architecture to provide a working
> copy_user_page() function, as reported by Michael Ellerman's kisskb
> build bot:
> 
> fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2
> 
> We already have a list of architectures that are known to be incompatible,
> but the list is missing ARC and SH at the moment. Further, blackfin and
> c6x also lack support for this function, but are already excluded because
> they do not support MMU-based kernels.

I've got a short list of patches for DAX; I'll add this one to the list.

Have the maintainers of these architectures been notified that they're
missing a core piece of kernel functionality?
