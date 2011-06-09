From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 09/14] i8253: Alpha, PowerPC: Remove unused
 <asm/8253pit.h> header.
Date: Thu, 09 Jun 2011 15:07:33 +1000
Message-ID: <1307596053.2874.267.camel@pasglop>
References: <20110601180456.801265664@duck.linux-mips.net>
	 <20110601180610.684557757@duck.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20110601180610.684557757@duck.linux-mips.net>
Sender: linux-alpha-owner@vger.kernel.org
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2011-06-01 at 19:05 +0100, ralf@linux-mips.org wrote:
> plain text document attachment
> (i8253-remove-unused-8253pit.h-files.patch)
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> To: linux-kernel@vger.kernel.org
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> 
>  arch/alpha/include/asm/8253pit.h   |    3 ---
>  arch/powerpc/include/asm/8253pit.h |    3 ---
>  2 files changed, 6 deletions(-)

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks !

Ben.

> Index: linux-mips/arch/alpha/include/asm/8253pit.h
> ===================================================================
> --- linux-mips.orig/arch/alpha/include/asm/8253pit.h
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -/*
> - * 8253/8254 Programmable Interval Timer
> - */
> Index: linux-mips/arch/powerpc/include/asm/8253pit.h
> ===================================================================
> --- linux-mips.orig/arch/powerpc/include/asm/8253pit.h
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -/*
> - * 8253/8254 Programmable Interval Timer
> - */
> 


