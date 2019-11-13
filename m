Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from m12-15.163.com ([220.181.12.15]:39292 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfKMA7i (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Nov 2019 19:59:38 -0500
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
 <20191112123125.GD17835@willie-the-truck>
From: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <cf0a0d1b-8680-7275-66b6-f704ef5cd89c@163.com>
Date: Wed, 13 Nov 2019 08:59:14 +0800
MIME-Version: 1.0
In-Reply-To: <20191112123125.GD17835@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yamada.masahiro@socionext.com, ast@kernel.org, daniel@iogearbox.net
Message-ID: <20191113005914.MXjYFHAcB3GudI9Y9bJSBzKKl2OE3BIDC3BO0VhTaUU@z>

On 11/12/19 8:31 PM, Will Deacon wrote:
> [+lkml, Masahiro, Alexei and Daniel]
>
> On Tue, Nov 12, 2019 at 04:56:39PM +0800, Xiao Yang wrote:
>> With your patch[1], I alway get the following error when building
>> tools/bpf:
> In case people want to reproduce this, my branch is here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=lto
>
>> ----------------------------------------------------------------------------------
>>
>> make -C tools/bpf/
>> make: Entering directory
>> '/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf'
>>
>> Auto-detecting system features:
>> ... libbfd: [ on ]
>> ... disassembler-four-args: [ OFF ]
>>
>> CC bpf_jit_disasm.o
>> CC bpf_dbg.o
>> In file included from
>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0,
>> from
>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41:
>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24:
>> fatal error: asm/rwonce.h: No such file or directory
>> #include <asm/rwonce.h>
>> ^
>> compilation terminated.
>> Makefile:61: recipe for target 'bpf_dbg.o' failed
>> make: *** [bpf_dbg.o] Error 1
>> make: *** Waiting for unfinished jobs....
>> make: Leaving directory
>>
>> ----------------------------------------------------------------------------------
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3
>>
>> It seems that include/linux/compiler.h cannot find the asm/rwonce.h because
>> tools/bpf/Makefile doesn't include arch/*/include/generated/asm/rwonce.h.
> The problem with referring to the generated files is that they don't exist
> unless you've configured the main source directory. The real problem here
> seems to be that tools/bpf/ refers directly to header files in the kernel
> sources without any understanding of kbuild, and therefore mandatory-y
> headers simply don't exist when it goes looking for them.
>
> Perhaps it's possible to introduce a dependency on a top-level "make
> asm-generic" so that we can reference the generated headers from the arch
> directly. Thoughts?

Hi Will,


Thanks for your reply.

I tried to do "make asm-generic" operation before, but it just generated 
asm/rwonce.h

in arch/*/include/generated directory and building tools/bpf still 
cannot find it.

Perhaps, the Makefile of tools/bpf needs to be improved.


Best Regards,

Xiao Yang

>
> Will
