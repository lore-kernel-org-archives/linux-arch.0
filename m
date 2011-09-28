From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 06/24] C6X: early boot code
Date: Wed, 28 Sep 2011 15:26:07 +0200
Message-ID: <201109281526.07969.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-7-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51509 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1I1N0T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 09:26:19 -0400
In-Reply-To: <1317155405-26235-7-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:

> +int c6x_num_cores;
> +EXPORT_SYMBOL(c6x_num_cores);
> +
> +unsigned int c6x_silicon_rev;
> +EXPORT_SYMBOL(c6x_silicon_rev);
> +
> +/*
> + * Device status register. This holds information
> + * about device configuration needed by some drivers.
> + */
> +unsigned int c6x_devstat;
> +EXPORT_SYMBOL(c6x_devstat);

> +unsigned int ticks_per_ns_scaled;
> +EXPORT_SYMBOL(ticks_per_ns_scaled);
> +
> +unsigned int c6x_core_freq;
> +EXPORT_SYMBOL(c6x_core_freq);

These all look like they are used internally (maybe not
ticks_per_ns_scaled) so it would be more appropriate to make
them EXPORT_SYMBOL_GPL.

	Arnd
