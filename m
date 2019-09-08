From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] powerpc/lockdep: fix a false positive warning
Date: Sun, 8 Sep 2019 10:32:58 +0200
Message-ID: <20190908083257.GA126088@gmail.com>
References: <20190906231754.830-1-cai@lca.pw>
 <20190907070505.GA88784@gmail.com>
 <420D09F4-FC19-421C-AE46-4B2A9157FAE3@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <420D09F4-FC19-421C-AE46-4B2A9157FAE3@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, bvanassche@acm.org, arnd@arndb.de, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
List-Id: linux-arch.vger.kernel.org


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
