From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 03/31] nds32: Support early_printk
Date: Wed, 8 Nov 2017 10:47:06 +0100
Message-ID: <20171108094705.GK1370@distanz.ch>
References: <cover.1510118606.git.green.hu@gmail.com>
 <f01f62d9666876052cc37043b605b60355bf54d7.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:43801 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751306AbdKHJrJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Nov 2017 04:47:09 -0500
Content-Disposition: inline
In-Reply-To: <f01f62d9666876052cc37043b605b60355bf54d7.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, Rick Chen <rick@andestech.com>

On 2017-11-08 at 06:54:51 +0100, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> Signed-off-by: Rick Chen <rick@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  arch/nds32/kernel/early_printk.c |  124 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 arch/nds32/kernel/early_printk.c
> 
> diff --git a/arch/nds32/kernel/early_printk.c b/arch/nds32/kernel/early_printk.c
> new file mode 100644
> index 0000000..269c3cd
> --- /dev/null
> +++ b/arch/nds32/kernel/early_printk.c

Could be implemented using earlycon (the 8250 drivers already supports
it) instead of duplicating functionality in arch/nds32?  See e.g. the
nios2 port for how this could be done, specifically commit e118c3fec9c0
("nios2: remove custom early console implementation").
