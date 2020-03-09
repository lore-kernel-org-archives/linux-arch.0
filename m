From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
Date: Mon, 9 Mar 2020 18:27:08 +0800
Message-ID: <95e3bba4-65c0-8991-9523-c16977f6350f@c-sky.com>
References: <20200308094954.13258-1-guoren@kernel.org>
 <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42580 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbgCIK1N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 06:27:13 -0400
In-Reply-To: <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <greentime.hu@sifive.com>, guoren@kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, Guo Ren <guoren@linux.alibaba.com>, Dave Martin <Dave.Martin@arm.com>



On 2020/3/9 11:41, Greentime Hu wrote:
> On Sun, Mar 8, 2020 at 5:50 PM <guoren@kernel.org> wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
>> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
>>
>> The patch implement basic context switch, sigcontext save/restore and
>> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
>> is implemented. We need to discuss about vlen-size for libc sigcontext and
>> ptrace (the maximum size of vlen is unlimited in spec).
>>
>> Puzzle:
>> Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
>> before, and riscv also met vlen size problem. Let's discuss the common issue
>> for all architectures and we need a better solution for unlimited vlen.
>>
>> Any help are welcomed :)
>>
>>   1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3
> Hi Guo,
>
> Thanks for your patch.
> It seems the qemu repo doesn't have this branch?
Hi Greentime,

It's a promise from me. Now it's ready.  You can turn on vector by 
"qemu-system-riscv64 -cpu rv64,v=true,vext_spec=v0.7.1".

Zhiwei
