From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 9/9] RISC-V: Build Infastructure
Date: Thu, 29 Jun 2017 09:29:35 -0700 (PDT)
Message-ID: <mhng-f6830643-823f-489f-a0bf-d07dab7a72c0@palmer-si-x1c4>
References: <20170628212500.GN6973@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33127 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdF2Q3h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2017 12:29:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so12497081pgb.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 09:29:37 -0700 (PDT)
In-Reply-To: <20170628212500.GN6973@jhogan-linux.le.imgtec.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: james.hogan@imgtec.com
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Wed, 28 Jun 2017 14:25:00 PDT (-0700), james.hogan@imgtec.com wrote:
> Hi Palmer,
>
> On Wed, Jun 28, 2017 at 11:55:38AM -0700, Palmer Dabbelt wrote:
>> +	select SYSRISCV_ATOMIC if !ISA_A
> ...
>> +config SYSRISCV_ATOMIC
>> +	bool "Include support for atomic operation syscalls"
>> +	default !ISA_A
>> +	help
>> +	  If atomic memory instructions are present, i.e.,
>> +	  CONFIG_ISA_A, this includes support for the syscall that
>> +	  provides atomic accesses.  This is only useful to run
>> +	  binaries that require atomic access but were compiled with
>> +	  -mno-atomic.
>> +
>> +	  If CONFIG_ISA_A is unset, this option is mandatory.
>> +
>> +	  If you don't know what to do here, say N.
>
> Can this be removed now that you mentioned the atomics syscall being
> mandatory? I can't find any other references to it.

Oh, sorry, I must have just missed it when swizzling that around.  I'll remove
it as part of our v4.

  diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
  index 38c8112861fd..9f587af28910 100644
  --- a/arch/riscv/Kconfig
  +++ b/arch/riscv/Kconfig
  @@ -155,20 +155,6 @@ config ISA_A

             If you don't know what to do here, say Y.

  -config SYSRISCV_ATOMIC
  -       bool "Include support for atomic operation syscalls"
  -       default !ISA_A
  -       help
  -         If atomic memory instructions are present, i.e.,
  -         CONFIG_ISA_A, this includes support for the syscall that
  -         provides atomic accesses.  This is only useful to run
  -         binaries that require atomic access but were compiled with
  -         -mno-atomic.
  -
  -         If CONFIG_ISA_A is unset, this option is mandatory.
  -
  -         If you don't know what to do here, say N.
  -
   config RV_PUM
          def_bool y
          prompt "Protect User Memory" if EXPERT

Thanks for catching this!
