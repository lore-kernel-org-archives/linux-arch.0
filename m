Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from m12-11.163.com ([220.181.12.11]:34759 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfKLI4v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Nov 2019 03:56:51 -0500
From: Xiao Yang <ice_yangxiao@163.com>
Subject: Question about "asm/rwonce.h: No such file or directory"
Message-ID: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
Date: Tue, 12 Nov 2019 16:56:39 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will@kernel.org
Cc: linux-arch@vger.kernel.org

Hi Will,


With your patch[1], I alway get the following error when building tools/bpf:

----------------------------------------------------------------------------------

make -C tools/bpf/
make: Entering directory
'/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf'

Auto-detecting system features:
... libbfd: [ on ]
... disassembler-four-args: [ OFF ]

CC bpf_jit_disasm.o
CC bpf_dbg.o
In file included from
/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0,
from
/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41:
/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24:
fatal error: asm/rwonce.h: No such file or directory
#include <asm/rwonce.h>
^
compilation terminated.
Makefile:61: recipe for target 'bpf_dbg.o' failed
make: *** [bpf_dbg.o] Error 1
make: *** Waiting for unfinished jobs....
make: Leaving directory

----------------------------------------------------------------------------------

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3


It seems that include/linux/compiler.h cannot find the asm/rwonce.h 
because tools/bpf/Makefile doesn't include 
arch/*/include/generated/asm/rwonce.h.

Did I miss some operations to build tools/bpf?


Best Regards,

XIao Yang
