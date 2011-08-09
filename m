From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/24] C6X: time management
Date: Tue, 9 Aug 2011 18:35:06 +0200
Message-ID: <201108091835.06442.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-11-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56352 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab1HIQfK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:35:10 -0400
In-Reply-To: <1312839879-13592-11-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:

> +#ifndef _ASM_C6X_TIMEX_H
> +#define _ASM_C6X_TIMEX_H
> +
> +/*
> + * This should be close enough...
> + */
> +#define CLOCK_TICK_RATE ((1000 * 1000000UL) / 6)
> +

We're about to remove that symbol and all its users, you should not need it
in 3.2 any more (though you still do in 3.1-rc1).

> +static cycle_t tsc_read(struct clocksource *cs)
> +{
> +	return get_cycles();
> +}

What is this good for? TSC is an x86 specific feature, so you should just
be able to use get_cycles directly.

	Arnd
