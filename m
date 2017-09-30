Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from yes.iam.tj ([109.74.197.121]:57098 "EHLO iam.tj"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751566AbdI3WmU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 30 Sep 2017 18:42:20 -0400
From: Tj <linux@iam.tj>
Subject: Regression: x86/mm: Add Secure Memory Encryption (SME) support
Message-ID: <d5c60048-dbb3-0440-d139-ea325621e654@iam.tj>
Date: Sat, 30 Sep 2017 23:36:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20170930223635.fK2-H4JrZN6J-10KaA_oq2oE7hMcrAO4Fcw8jtbXEDA@z>

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
