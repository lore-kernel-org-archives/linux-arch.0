From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 01/17] alpha: Use Kbuild logic to include <asm-generic/sections.h>
Date: Wed, 13 Nov 2013 07:23:52 +1000
Message-ID: <52829C68.6090409@twiddle.net>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org> <1384285347-13506-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <1384285347-13506-2-git-send-email-geert@linux-m68k.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 11/13/2013 05:42 AM, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/include/asm/Kbuild     |    2 +-
>  arch/alpha/include/asm/sections.h |    7 -------
>  2 files changed, 1 insertion(+), 8 deletions(-)
>  delete mode 100644 arch/alpha/include/asm/sections.h

Acked-by: Richard Henderson <rth@twiddle.net>


r~
