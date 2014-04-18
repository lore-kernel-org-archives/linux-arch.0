Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:53814 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984AbaDRTbX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2014 15:31:23 -0400
Message-ID: <1397848572.4750.4.camel@x220>
Subject: Re: [PATCH 01/28] nios2: Build infrastructure
From: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 18 Apr 2014 21:16:12 +0200
In-Reply-To: <1397824031-4892-2-git-send-email-lftan@altera.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	 <1397824031-4892-2-git-send-email-lftan@altera.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140418191612.9HnP4-23AyDxnhhG3-_vWX6uW-Sv3LCiB-QVI8x2voA@z>

On Fri, 2014-04-18 at 20:26 +0800, Ley Foon Tan wrote:
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
>[...]
> +config GENERIC_FIND_NEXT_BIT
> +	def_bool y

This one is not needed, see commit 63e424c84429 ("arch: remove
CONFIG_GENERIC_FIND_{NEXT_BIT,BIT_LE,LAST_BIT}").

> +config NO_IOPORT
> +	def_bool y

Did you mean NO_IOPORT_MAP?


Paul Bolle

