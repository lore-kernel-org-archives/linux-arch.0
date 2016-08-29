From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch: all: include: asm: bitops: Use bool instead of int for all bit test functions
Date: Mon, 29 Aug 2016 15:03:41 +0200
Message-ID: <201608291503.41630.arnd@arndb.de>
References: <1472362755-26776-1-git-send-email-chengang@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:51053 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932715AbcH2NTV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2016 09:19:21 -0400
In-Reply-To: <1472362755-26776-1-git-send-email-chengang@emindsoft.com.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: chengang@emindsoft.com.cn
Cc: akpm@linux-foundation.org, minchan@kernel.org, vbabka@suse.cz, gi-oh.kim@profitbricks.com, iamjoonsoo.kim@lge.com, hillf.zj@alibaba-inc.com, mgorman@techsingularity.net, mhocko@suse.com, rientjes@google.com, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org, davem@dave

On Sunday 28 August 2016, chengang@emindsoft.com.cn wrote:
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> Also use the same changing to asm-generic, and also use bool variable
> instead of int variable for mips, mn10300, parisc and tile related
> functions, and also avoid checkpatch.pl to report ERROR.
> 
> Originally, except powerpc and xtensa, all another architectures intend
> to return 0 or 1. After this patch, also let powerpc and xtensa return 0
> or 1.
> 
> The patch passes cross building for mips and parisc with default config.
> All related contents are found by "grep test_bit, grep test_and" under
> arch sub-directory.
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>

This seems like a good idea overall, and I'm fine with the asm-generic
contents. If there is consensus on changing this, we probably also want
to do some other steps:

- Change the Documentation/atomic_ops.txt file accordingly
- split up the series per architecture (I don't think there are any
  interdependencies)
- For the architectures on which the definition changes (at least
  x86 and ARM), do some more sanity checks and see if there are
  noticeable changes in object code, and if so whether it looks
  better or worse (I'm guessing it will be better if anything)
- See which architectures can still get converted to using the
  asm-generic headers instead of providing their own, I think at
  least for the nonatomic ones, there are a couple.

	Arnd
