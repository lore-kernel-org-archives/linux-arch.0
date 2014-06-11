From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
Date: Wed, 11 Jun 2014 15:22:40 -0700
Message-ID: <CALCETrVMxkHcPXsEGtEc0Pr=Z80CzC0zWaQ9OdVdxi1CGuB4kQ@mail.gmail.com>
References: <cover.1402517933.git.luto@amacapital.net> <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
 <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com>
 <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com> <5398D59A.3030900@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5398D59A.3030900@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org, linux-arch <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 11, 2014 at 3:18 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 06/11/2014 02:56 PM, Andy Lutomirski wrote:
>>
>> 13ns is with the simplest nonempty filter.  I hope that empty filters
>> don't work.
>>
>
> Why wouldn't they?

Is it permissible to fall off the end of a BPF program?  I'm getting
EINVAL trying to install an actual empty filter.  The filter I tested
with was:

#include <unistd.h>
#include <linux/filter.h>
#include <linux/seccomp.h>
#include <sys/syscall.h>
#include <err.h>
#include <sys/prctl.h>
#include <stddef.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    int rc;

    struct sock_filter filter[] = {
        BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
    };

    struct sock_fprog prog = {
        .len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
        .filter = filter,
    };

    if (argc < 2) {
        printf("Usage: null_seccomp PATH ARGS...\n");
        return 1;
    }

    if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
        err(1, "PR_SET_NO_NEW_PRIVS");
    if (prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog))
        err(1, "PR_SET_SECCOMP");

    execv(argv[1], argv + 1);
    err(1, argv[1]);
}


--Andy
