Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42260 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfIHIdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Sep 2019 04:33:03 -0400
Date: Sun, 8 Sep 2019 10:32:58 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] powerpc/lockdep: fix a false positive warning
Message-ID: <20190908083257.GA126088@gmail.com>
References: <20190906231754.830-1-cai@lca.pw>
 <20190907070505.GA88784@gmail.com>
 <420D09F4-FC19-421C-AE46-4B2A9157FAE3@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <420D09F4-FC19-421C-AE46-4B2A9157FAE3@lca.pw>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, bvanassche@acm.org, arnd@arndb.de, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Message-ID: <20190908083258.bzS_7nHmR-8AxMK-vhyfzWa6G6GriL3uNmpMUUjNW1A@z>


* Qian Cai <cai@lca.pw> wrote:

> I thought about making it a bool in the first place, but since all 
> other similar helpers (arch_is_kernel_initmem_freed(), 
> arch_is_kernel_text(), arch_is_kernel_data() etc) could be bool too but 
> are not, I kept arch_is_bss_hole() just to be “int” for consistent.
> 
> Although then there is is_kernel_rodata() which is bool. I suppose I’ll 
> change arch_is_bss_hole() to bool, and then could have a follow-up 
> patch to covert all similar helpers to return boo instead.

Sounds good to me.

Thanks,

	Ingo
