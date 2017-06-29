From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 7/9] RISC-V: Paging and MMU
Date: Thu, 29 Jun 2017 15:11:43 -0700 (PDT)
Message-ID: <mhng-6d9276ff-c67c-48c2-9a44-a269feede04d@palmer-si-x1c4>
References: <20170628230959.GQ6973@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35006 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbdF2WLo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2017 18:11:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so14635484pfs.2
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 15:11:44 -0700 (PDT)
In-Reply-To: <20170628230959.GQ6973@jhogan-linux.le.imgtec.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: james.hogan@imgtec.com
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Wed, 28 Jun 2017 16:09:59 PDT (-0700), james.hogan@imgtec.com wrote:
> On Wed, Jun 28, 2017 at 11:55:36AM -0700, Palmer Dabbelt wrote:
>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>> new file mode 100644
>> index 000000000000..e1491c20d6fd
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/page.h
> ...
>> +#ifdef __KERNEL__
>
> I think thats a given outside of uapi.

Thanks.  I've removed those.
