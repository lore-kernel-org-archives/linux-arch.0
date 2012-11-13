From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [GIT PULL] UAPI: perf fixes
Date: Tue, 13 Nov 2012 10:42:02 -0500
Message-ID: <CA+5PVA6qaxCzr8RBV616D3kEXyj9XjS3okeZXhJJL1R4+-Yv_A@mail.gmail.com>
References: <1378.1352379110@warthog.procyon.org.uk>
	<CA+5PVA5vMyNmQYCLX315Jc+kN9zQuZo_h0Devpjfr43TezE-qA@mail.gmail.com>
	<18065.1352820271@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18065.1352820271@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: acme@ghostprotocols.net, xiaoguangrong@linux.vnet.ibm.com, mingo@kernel.org, haodong@linux.vnet.ibm.com, runzhen@linux.vnet.ibm.com, dsahern@gmail.com, tglx@linutronix.de, bp@alien8.de, namhyung@gmail.com, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 13, 2012 at 10:24 AM, David Howells <dhowells@redhat.com> wrote:
> Josh Boyer <jwboyer@gmail.com> wrote:
>
>> This patch seems to break building perf on ppc64.  It fails with:
>>
>> + make -j16 -C tools/perf -s V=1 WERROR=0 HAVE_CPLUS_DEMANGLE=1 prefix=/usr all
>>
>> <snip>
>>
>> builtin-kvm.c:25:21: fatal error: asm/svm.h: No such file or directory
>
> tools/perf/builtin-kvm.c became x86-only with the following commit:
>
>         commit bcf6edcd6fdb8965290f0b635a530fa3c6c212e1
>         Author: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
>         Date:   Mon Sep 17 16:31:15 2012 +0800
>         Subject: perf kvm: Events analysis tool
>
> when it added:
>
>         +#include "../../arch/x86/include/asm/svm.h"
>         +#include "../../arch/x86/include/asm/vmx.h"
>         +#include "../../arch/x86/include/asm/kvm.h"
>
> and my changing these to <asm/foo.h> doesn't matter because of this in the
> same file:
>
>         +struct exit_reasons_table vmx_exit_reasons[] = {
>         +       VMX_EXIT_REASONS
>         +};
>         +
>         +struct exit_reasons_table svm_exit_reasons[] = {
>         +       SVM_EXIT_REASONS
>         +};
>
> which use macros only x86 defines.

Ah.  You are quite right.  So your patches actually fix the unistd.h
error we were seeing early and just got us far enough to hit this other
unrelated problem.  My mistake.

> Should the exported parts of these files be moved to asm-generic?

Good question.

josh
