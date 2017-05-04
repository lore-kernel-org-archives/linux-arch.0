From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h
Date: Thu, 4 May 2017 10:01:30 +0200
Message-ID: <CAK8P3a01_4mZZbB74hyWO_OXmT-cOd4ezZQoeOA23xh7N-0MFw@mail.gmail.com>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com> <20170503145141.4966-3-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33440 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdEDIBb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2017 04:01:31 -0400
In-Reply-To: <20170503145141.4966-3-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

On Wed, May 3, 2017 at 4:51 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> The "qspinlock_types.h" doesn't need linux/atomic.h directly. So
> because of this, and because including of it requires the protection
> against recursive inclusion, it looks reasonable to move the
> inclusion exactly where it is needed. This change affects the x86_64
> arch, as the only user of qspinlocks at now. I have build-tested the
> change on x86_64 with CONFIG_PARAVIRT enabled and disabled.
>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Please keep this together with the other patches as they get merged through
the arm64 tree.

       Arnd
