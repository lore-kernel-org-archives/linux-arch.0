From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] nios2: add ioremap_nocache declaration before include
 asm-generic/io.h.
Date: Fri, 2 Mar 2018 09:50:50 +0100
Message-ID: <20180302085050.GI19044@distanz.ch>
References: <20180301163943.10887-1-greentime@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180301163943.10887-1-greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: lftan@altera.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, greentime@andestech.com
List-Id: linux-arch.vger.kernel.org

On 2018-03-01 at 17:39:43 +0100, Greentime Hu <green.hu@gmail.com> wrote:
> A commit for the nds32 architecture bootstrap("asm-generic/io.h:
> move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef
> CONFIG_MMU") will move the ioremap_nocache out of the CONFIG_MMU ifdef.
> This means that in order to suppress re-definition errors we need to
> setup #define's before importing asm-generic/io.h.
> 
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
