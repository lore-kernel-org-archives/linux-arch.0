From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v2 0/6] early_res: fw_memmap.c
Date: Wed, 10 Mar 2010 13:24:21 -0800
Message-ID: <1268256267-3769-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:62727 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab0CJVZX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Mar 2010 16:25:23 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

use wake_system_ram_range instead if needed.

-v2: move common memmap fo fw_memmap.c
     convert for sparc64

Thanks

Yinghai
