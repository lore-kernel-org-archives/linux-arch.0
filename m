From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v4 00/08] use lmb with x86
Date: Wed, 24 Mar 2010 03:34:13 -0700
Message-ID: <1269426861-20903-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

new early_res is lmb extension. and it could be used to replace bootmem.

even could share some code before bootmem, like register_active_region, and
lm_reserved_to_bootmem

add test version for powerpc

Thanks

Yinghai
