Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:52481 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753153AbaDRTlr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2014 15:41:47 -0400
Message-ID: <1397850104.4750.8.camel@x220>
Subject: Re: [PATCH 01/28] nios2: Build infrastructure
From: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 18 Apr 2014 21:41:44 +0200
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
Message-ID: <20140418194144.fNVoQUzxgrd0a5xLk-5Lko85kykiLQDyxtcdjsuRK-0@z>

On Fri, 2014-04-18 at 20:26 +0800, Ley Foon Tan wrote:
> diff --git a/arch/nios2/kernel/Makefile b/arch/nios2/kernel/Makefile
[...]
> +obj-$(CONFIG_CONSOLE)		+= console.o

CONFIG_CONSOLE seems never to be defined. And there appears to be no
arch/nios2/console.c or .../console.S anyway.


Paul Bolle

