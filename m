From: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
Subject: Re: [PATCH 16/37] net/usb: use get/put_endian helpers
Date: Sat, 31 May 2008 02:43:36 +0300
Message-ID: <20080531024336.gszdaepdog8woow0@hayate.ip6>
References: <1212092310.28403.118.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.dnainternet.fi ([87.94.96.112]:40521 "EHLO
	smtp2.dnainternet.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYE3Xvz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 19:51:55 -0400
In-Reply-To: <1212092310.28403.118.camel@brick>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: dbrownell@users.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>, linux-netdev <netdev@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

Quoting Harvey Harrison <harvey.harrison@gmail.com>:

> diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
> index ae467f1..bda89c9 100644
> --- a/drivers/net/usb/rndis_host.c
> +++ b/drivers/net/usb/rndis_host.c
> @@ -407,7 +407,7 @@ generic_rndis_bind(struct usbnet *dev, struct   
> usb_interface *intf, int flags)
>  	u.set->oid = OID_GEN_CURRENT_PACKET_FILTER;
>  	u.set->len = ccpu2(4);
>  	u.set->offset = ccpu2((sizeof *u.set) - 8);
> -	*(__le32 *)(u.buf + sizeof *u.set) = RNDIS_DEFAULT_FILTER;
> +	put_le32(RNDIS_DEFAULT_FILTER, (__le32 *)(u.buf + sizeof(*u.set)));
>
>  	retval = rndis_command(dev, u.header);
>  	if (unlikely(retval < 0)) {

RNDIS_DEFAULT_FILTER already is le32, put_le32 breaks it.

  - Jussi
