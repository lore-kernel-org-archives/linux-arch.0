From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 12/17] tty: New RISC-V SBI Console Driver
Date: Fri, 23 Jun 2017 17:45:23 -0700 (PDT)
Message-ID: <mhng-ff4db4ff-d1b4-4f40-8488-7c5b0bf52b67@palmer-si-x1c4>
References: <CAK8P3a35SEeOaVXBNCzUiwQTXys4MZN28d4yVRqNQ=Jz=Z-EWw@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a35SEeOaVXBNCzUiwQTXys4MZN28d4yVRqNQ=Jz=Z-EWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: geert@linux-m68k.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, gregkh@linuxfoundation.org, jslaby@suse.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Wed, 07 Jun 2017 00:58:04 PDT (-0700), Arnd Bergmann wrote:
> On Wed, Jun 7, 2017 at 9:15 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> CC (hypervisor) console folks
>>
>> On Wed, Jun 7, 2017 at 1:00 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>> This patch adds a new driver for the console availiable via the RISC-V
>>> SBI.  This console is specified to be used for early boot messages, and
>>> is designed to be a very simple (albiet somewhat slow) console that is
>>> always availiable.  All RISC-V systems have an SBI console.
>>>
>>> The SBI console is made availiable for early printk messages and is also
>>> availiable as a regular console.
>>>
>>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>>> ---
>>>  drivers/tty/hvc/Kconfig   |  11 +++++
>>>  drivers/tty/hvc/Makefile  |   1 +
>>>  drivers/tty/hvc/hvc_sbi.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 114 insertions(+)
>>>  create mode 100644 drivers/tty/hvc/hvc_sbi.c
>>>
>>> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
>>> index 574da15fe618..f3774adab240 100644
>>> --- a/drivers/tty/hvc/Kconfig
>>> +++ b/drivers/tty/hvc/Kconfig
>>> @@ -114,4 +114,15 @@ config HVCS
>>>           which will also be compiled when this driver is built as a
>>>           module.
>>>
>>> +config HVC_SBI
>>> +       bool "SBI console support"
>>> +       depends on RISCV
>>> +       select HVC_DRIVER
>>> +       default y
>>> +       help
>>> +         This enables support for console output via RISC-V SBI calls, which
>>> +         is normally used only during boot to output printk.
>>> +
>>> +         If you don't know what do to here, say Y.
>>> +
>>>  endif # TTY
>
> Please move this a little higher along with the other HVC_DRIVER
> implementations.

OK: https://github.com/riscv/riscv-linux/commit/1c769cad7931b7b08644d2d4a7b6985777a8e0be

>>> + * RISC-V SBI interface to hvc_console.c
>>> + *  based on drivers-tty/hvc/hvc_udbg.c
>>> + *
>>> + * Copyright (C) 2008 David Gibson, IBM Corporation
>>> + * Copyright (C) 2012 Regents of the University of California
>
> 2017?

https://github.com/riscv/riscv-linux/commit/dafa678d26886076a8a9cccc2486f1bbbfa44aa8
