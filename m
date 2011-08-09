From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/24] C6X: devicetree
Date: Tue, 9 Aug 2011 18:14:45 +0200
Message-ID: <201108091814.45424.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-7-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51248 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab1HIQOr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:14:47 -0400
In-Reply-To: <1312839879-13592-7-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/c6x/boot/dts/dsk6455.dts  |   87 +++++++++++++
>  arch/c6x/boot/dts/evmc6457.dts |   88 +++++++++++++
>  arch/c6x/boot/dts/evmc6472.dts |  129 +++++++++++++++++++
>  arch/c6x/boot/dts/evmc6474.dts |  105 +++++++++++++++
>  arch/c6x/boot/install-dtb.c    |  275 ++++++++++++++++++++++++++++++++++++++++
>  arch/c6x/kernel/devicetree.c   |   53 ++++++++

I don't see anything wrong with these, but please take the device tree mailing list on
Cc when posting this patch again.

	Arnd
