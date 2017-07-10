From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patches] [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Mon, 10 Jul 2017 13:39:50 -0700 (PDT)
Message-ID: <mhng-a56cb230-6333-4bac-a093-546ad5dac8eb@palmer-si-x1c4>
References: <20170707131607.enpeooybtvzhbugh@latitude>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33217 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754601AbdGJUjw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2017 16:39:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so14011039pgb.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2017 13:39:52 -0700 (PDT)
In-Reply-To: <20170707131607.enpeooybtvzhbugh@latitude>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: j.neuschaefer@gmx.net
Cc: patches@groups.riscv.org, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Fri, 07 Jul 2017 06:16:07 PDT (-0700), j.neuschaefer@gmx.net wrote:
> On Tue, Jul 04, 2017 at 12:50:55PM -0700, Palmer Dabbelt wrote:
> [...]
>> +/* These barries need to enforce ordering on both devices or memory. */
>
> Very minor nit: s/barries/barriers/ (in several places)

I think this should do it

  https://github.com/riscv/riscv-linux/commit/b356e7a2223b5e21df424ea7e9900e5bf408762f

Thanks!
