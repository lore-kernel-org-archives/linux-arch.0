From: Tj <linux@iam.tj>
Subject: Regression: x86/mm: Add Secure Memory Encryption (SME) support
Date: Sat, 30 Sep 2017 23:36:35 +0100
Message-ID: <d5c60048-dbb3-0440-d139-ea325621e654@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

With 4.14.0rc2 on an Intel CPU with an Nvidia GPU the proprietary nvidia
driver (v340.102) fails to modpost due to:

FATAL: modpost: GPL-incompatible module nvidia.ko uses GPL-only symbol
'sme_me_mask'

I think this is due to:

config ARCH_HAS_MEM_ENCRYPT
       def_bool y


I noticed that a grep of the built kernel for "sme_me_mask" shows the
symbol imported into more than 300 modules on an Ubuntu mainline build
of 4.14.0-041400rc2-lowlatency.

Should the new symbol be referenced so widely and how can it be
prevented from being included in proprietary modules on systems that
don't have SME even if the kernel is built with it enabled?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
