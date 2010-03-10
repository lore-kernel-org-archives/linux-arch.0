From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 5/6] early_res: seperate common memmap func from e820.c
 to fw_memmap.c
Date: Wed, 10 Mar 2010 13:55:25 -0800 (PST)
Message-ID: <20100310.135525.214295069.davem@davemloft.net>
References: <1268256267-3769-1-git-send-email-yinghai@kernel.org>
	<1268256267-3769-6-git-send-email-yinghai@kernel.org>
	<20100310215018.GD24353@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49525
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932769Ab0CJVzF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Mar 2010 16:55:05 -0500
In-Reply-To: <20100310215018.GD24353@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rmk+lkml@arm.linux.org.uk
Cc: yinghai@kernel.org, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Wed, 10 Mar 2010 21:50:18 +0000

> Where are patches 1 to 4?

They were x86 specific, from the perspective of your architecture
you only need to look at the non-x86 parts of patch #5
