Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout.easymail.ca ([64.68.200.34]:37809 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeEDTjo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 May 2018 15:39:44 -0400
Subject: Re: [PATCH] selftests/x86: Detect -no-pie availability
References: <20180502121433.7F874401F1BF7@oldenburg.str.redhat.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f55777ec-53e5-ad7a-dca9-6313dc779342@kernel.org>
Date: Fri, 4 May 2018 13:39:33 -0600
MIME-Version: 1.0
In-Reply-To: <20180502121433.7F874401F1BF7@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>, linux-x86_64@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>

On 05/02/2018 06:10 AM, Florian Weimer wrote:
> Some toolchains need -no-pie to build all tests, others do not support
> the -no-pie flag at all.  Therefore, add another test for the
> availability of the flag.
> 
> This amends commit 3346a6a4e5ba8c040360f753b26938cec31a4bdc
> ("selftests: x86: sysret_ss_attrs doesn't build on a PIE build").
> 
> Signed-off-by: Florian Weimer <fweimer@redhat.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  tools/testing/selftests/x86/Makefile          |  8 +++++++-
>  tools/testing/selftests/x86/trivial_program.c | 10 ++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/x86/trivial_program.c
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index d744991c0f4f..94c89261a236 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -8,6 +8,7 @@ include ../lib.mk
>  UNAME_M := $(shell uname -m)
>  CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
>  CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
> +CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
>  
>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
>  			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
> @@ -31,7 +32,12 @@ BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
>  BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>  BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
>  
> -CFLAGS := -O2 -g -std=gnu99 -pthread -Wall -no-pie
> +CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
> +
> +# call32_from_64 in thunks.S uses absolute addresses.
> +ifeq ($(CAN_BUILD_WITH_NOPIE),1)
> +CFLAGS += -no-pie
> +endif
>  
>  define gen-target-rule-32
>  $(1) $(1)_32: $(OUTPUT)/$(1)_32
> diff --git a/tools/testing/selftests/x86/trivial_program.c b/tools/testing/selftests/x86/trivial_program.c
> new file mode 100644
> index 000000000000..46a447163b93
> --- /dev/null
> +++ b/tools/testing/selftests/x86/trivial_program.c
> @@ -0,0 +1,10 @@
> +/* Trivial program to check that compilation with certain flags is working. */
> +
> +#include <stdio.h>
> +
> +int
> +main(void)
> +{
> +	puts("");
> +	return 0;
> +}
> 

Thanks. I will queue this up for 4.18-rc1

thahnks,
-- Shuah
