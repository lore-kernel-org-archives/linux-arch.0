Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:55508 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbaJ1Ni0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Oct 2014 09:38:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 29/29] nios2: Build infrastructure
Date: Tue, 28 Oct 2014 14:38:22 +0100
Message-ID: <2095416.INZmt8AD1y@wuerfel>
In-Reply-To: <1414139071-3818-30-git-send-email-lftan@altera.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com> <1414139071-3818-30-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20141028133822.s_-G-5KVQPRkqQsEZgUT4VOzO571v0WDytnz_LR68mE@z>

On Friday 24 October 2014 16:24:31 Ley Foon Tan wrote:
> +DECLARE_EXPORT(__gcc_bcmp);
> +DECLARE_EXPORT(__divdi3);
> +DECLARE_EXPORT(__divsi3);
> +DECLARE_EXPORT(__moddi3);
> +DECLARE_EXPORT(__modsi3);
> +DECLARE_EXPORT(__udivdi3);
> +DECLARE_EXPORT(__udivmoddi4);
> +DECLARE_EXPORT(__udivsi3);
> +DECLARE_EXPORT(__umoddi3);
> +DECLARE_EXPORT(__umodsi3);
> +DECLARE_EXPORT(__muldi3);
> 

I don't remember what all of these are, but at least some of them seem
to be concerned with 64-bit division. By convention, we don't provide those
in the Linux kernel but instead require all code to use the do_div()
macro instead.

	Arnd
