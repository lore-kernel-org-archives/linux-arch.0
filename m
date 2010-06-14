From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 2/5] blackfin: Remove *(.text.*) pattern from the linker
	script
Date: Mon, 14 Jun 2010 15:58:49 -0400
Message-ID: <AANLkTim61KGFgXWlzO71Zqav07AUVazohlcsTmygZaui@mail.gmail.com>
References: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
	<1276519112-11649-2-git-send-email-matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37941 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab0FNT7K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2010 15:59:10 -0400
In-Reply-To: <1276519112-11649-2-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 14, 2010 at 08:38, Matt Fleming wrote:
> From: Matt Fleming <matthew.fleming@imgtec.com>
>
> Drop the pattern from the linker script because the pattern is now
> provided by TEXT_TEXT.
>
> Signed-off-by: Matt Fleming <matthew.fleming@imgtec.com>

once the vmlinux.lds.h change gets merged:
Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
