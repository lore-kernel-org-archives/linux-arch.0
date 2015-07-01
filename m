From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] mm: cleaning per architecture MM hook header files
Date: Wed, 1 Jul 2015 14:54:08 +0200
Message-ID: <CAMuHMdWe0eEYm11LdDvQiAUV=XFYSM-ef2JueZn+rDtTt2H_Pg@mail.gmail.com>
References: <55924508.9080101@synopsys.com>
	<1435745853-27535-1-git-send-email-ldufour@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1435745853-27535-1-git-send-email-ldufour@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 1, 2015 at 12:17 PM, Laurent Dufour
<ldufour@linux.vnet.ibm.com> wrote:
> The commit 2ae416b142b6 ("mm: new mm hook framework") introduced an empty
> header file (mm-arch-hooks.h) for every architecture, even those which
> doesn't need to define mm hooks.
>
> As suggested by Geert Uytterhoeven, this could be cleaned through the use
> of a generic header file included via each per architecture
> asm/include/Kbuild file.
>
> The PowerPC architecture is not impacted here since this architecture has
> to defined the arch_remap MM hook.
>
> Changes in V2:
> --------------
>  - Vineet Gupta reported that the Kbuild files should be kept sorted.
>  - Add fix for the newly introduced H8/300 architecture.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> CC: linux-arch@vger.kernel.org
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
