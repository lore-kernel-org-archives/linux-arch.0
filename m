Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:27028 "EHLO
	rcsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab0CXKiO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2010 06:38:14 -0400
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v4 00/08] use lmb with x86
Date: Wed, 24 Mar 2010 03:34:13 -0700
Message-ID: <1269426861-20903-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20100324103413.YEPYVDjXxOrlbUXIyd18MmeeoHLu8XV7WGj2WMEED1s@z>

new early_res is lmb extension. and it could be used to replace bootmem.

even could share some code before bootmem, like register_active_region, and
lm_reserved_to_bootmem

add test version for powerpc

Thanks

Yinghai
