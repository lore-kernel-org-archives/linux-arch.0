From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 21/24] C6X: general SoC support
Date: Wed, 28 Sep 2011 16:19:07 +0200
Message-ID: <201109281619.07213.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-22-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58590 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1I1OTL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 10:19:11 -0400
In-Reply-To: <1317155405-26235-22-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> +int soc_mac_addr(unsigned int index, u8 *addr)
> +{
> +       int i, have_cmdline_mac = 0, have_fuse_mac = 0;
> +
> +       for (i = 0; i < 6; i++) {
> +               if (cmdline_mac[i])
> +                       have_cmdline_mac = 1;
> +               if (c6x_fuse_mac[i])
> +                       have_fuse_mac = 1;
> +       }
> +
> +       /* cmdline overrides hardware fuse MAC */
> +       if (have_cmdline_mac)
> +               memcpy(addr, cmdline_mac, 6);
> +       else if (have_fuse_mac)
> +               memcpy(addr, c6x_fuse_mac, 6);
> +       else
> +               return 0;

IMHO it's more important to let the user override the MAC address through
the device tree than the command line, although if you allow both, the
command line should take precedence. If you think you need to keep the
command line option, please add a way to read it from the device tree
as a fallback before falling back to the fused mac address.

Also, a final fallback on random_mac_address() would be reasonable here.

Finally, how about passing a struct device pointer from the driver, rather
than the index? That would seem more logical and make it easier to get
to the device tree properties.

> +       /* adjust for specific EMAC device */
> +       addr[5] += index * c6x_num_cores;
> +       return 1;
> +}
> +EXPORT_SYMBOL(soc_mac_addr);

EXPORT_SYMBOL_GPL()

	Arnd
