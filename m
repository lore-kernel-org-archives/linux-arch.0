From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 9/9] RISC-V: Build Infastructure
Date: Thu, 29 Jun 2017 15:11:41 -0700 (PDT)
Message-ID: <mhng-1f78b59f-b5ef-4b2d-a622-9255581d21c8@palmer-si-x1c4>
References: <20170628225442.GP6973@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170628225442.GP6973@jhogan-linux.le.imgtec.org>
Sender: linux-kernel-owner@vger.kernel.org
To: james.hogan@imgtec.com
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com
List-Id: linux-arch.vger.kernel.org

On Wed, 28 Jun 2017 15:54:42 PDT (-0700), james.hogan@imgtec.com wrote:
> On Wed, Jun 28, 2017 at 11:55:38AM -0700, Palmer Dabbelt wrote:
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> new file mode 100644
>> index 000000000000..7f58cd251ab8
>> --- /dev/null
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -0,0 +1,16 @@
>> +#
>> +# Makefile for the RISC-V Linux kernel
>> +#
>> +
>> +extra-y := head.o vmlinux.lds
>> +
>> +obj-y	:= cpu.o entry.o irq.o process.o ptrace.o reset.o setup.o \
>> +	   signal.o syscall_table.o sys_riscv.o time.o traps.o \
>> +	   riscv_ksyms.o stacktrace.o vdso.o cacheinfo.o vdso/
>
> I would suggest splitting these sort of things onto separate lines.
> It'll make later changes much more readable (especially when you're
> escaping newlines) as well as avoiding conflicts.
>
>> +
>> +CFLAGS_setup.o := -mcmodel=medany
>> +
>> +obj-$(CONFIG_SMP)		+= smpboot.o smp.o
>
> same here
>
>> +obj-$(CONFIG_MODULES)		+= module.o
>> +
>> +clean:
>
>> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
>> new file mode 100644
>> index 000000000000..120c38e77a46
>> --- /dev/null
>> +++ b/arch/riscv/lib/Makefile
>> @@ -0,0 +1,5 @@
>> +lib-y	:= delay.o memcpy.o memset.o uaccess.o
>
> and here
>
>> +
>> +ifeq ($(CONFIG_64BIT),)
>> +lib-y += udivdi3.o
>> +endif
>
> Would this work?
>
> lib-$(CONFIG_32BIT) += udivdi3.o
>
>> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
>> new file mode 100644
>> index 000000000000..36ebe6feb5d6
>> --- /dev/null
>> +++ b/arch/riscv/mm/Makefile
>> @@ -0,0 +1 @@
>> +obj-y := init.o fault.o extable.o ioremap.o
>
> and here

Sounds good.  I'll include this in the v4

  https://github.com/riscv/riscv-linux/commit/e5a3eee8cd3e493dcd9b81509b1aa9e0302b72da
