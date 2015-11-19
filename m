From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] include: asm-generic: page.h: Remove useless
 get_user_page and free_user_page
Date: Thu, 19 Nov 2015 11:44:34 +0530
Message-ID: <564D68CA.6010708@synopsys.com>
References: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
Sender: linux-m68k-owner@vger.kernel.org
To: Chen Gang <xili_gchen_5257@hotmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "gerg@uclinux.org" <gerg@uclinux.org>, "jonas@southpole.se" <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>, "abrodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, kernel mailing list <linux-kernel@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, linux@lists.openrisc.net, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 19 November 2015 01:10 AM, Chen Gang wrote:
> From ba7c00c4cb976109b6a35812ce9649aaeda81e2d Mon Sep 17 00:00:00 2001
> From: Chen Gang <gang.chen.5i5j@gmail.com>
> Date: Thu, 19 Nov 2015 03:24:42 +0800
> Subject: [PATCH] include: asm-generic: page.h: Remove useless get_user_page and free_user_page
> 
> They are not symmetric with each other, neither are used in real world
> (can not be found by grep command in source code root directory), so
> remove them.
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/arc/include/asm/page.h       | 3 ---
>  arch/arm/include/asm/page-nommu.h | 3 ---
>  arch/frv/include/asm/page.h       | 3 ---
>  arch/m68k/include/asm/page_mm.h   | 3 ---
>  arch/m68k/include/asm/page_no.h   | 3 ---
>  arch/openrisc/include/asm/page.h  | 3 ---
>  include/asm-generic/page.h        | 3 ---
>  7 files changed, 21 deletions(-)

So this is one huge patch touching several arches with potential to cause
conflicts when merged. Can u divy them up and then the maintainers can simply
merge them individually given there is no common dependency !
