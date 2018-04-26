From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -tip v2 0/7] kprobes: Fix %p in kprobes
Date: Thu, 26 Apr 2018 10:40:22 +0200
Message-ID: <20180426084022.GA6777@kroah.com>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152473007907.8819.10449983839199591406.stgit@devbox>
Sender: stable-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 26, 2018 at 05:08:00PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> This 2nd version of the series which fixes %p uses in kprobes.
> Some by replacing with %pS, some by replacing with %px but
> masking with kallsyms_show_value().
> 
> V1 series is here:
>  https://lkml.org/lkml/2018/1/25/1
> 
> I've read the thread about %pK and if I understand correctly
> we shouldn't print kernel addresses. However, kprobes debugfs
> interface can not stop to show the actual probe address because
> it should be compared with addresses in kallsyms for debugging.
> So, it depends on that kallsyms_show_value() allows to show
> address to user, because if it returns true, anyway that user
> can dump /proc/kallsyms.
> 
> Other error messages are replaced it with %pS, and one critical
> function uses %px which is called right before BUG().
> 
> Also, I tried to fix this issue on each arch port. I searched
> it by
> 
>  # find arch/* | grep -e 'kprobe.*c' | xargs grep -w %p
> 
> And fixed all %p uses in those files.
> 
> Changes in this version;
>  - [1/7] is newly added.
>  - patches for MN10300(deleted) and s390(merged) are removed.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (7):
>       kprobes: Make blacklist root user read only
>       kprobes: Show blacklist addresses as same as kallsyms does
>       kprobes: Show address of kprobes if kallsyms does
>       kprobes: Replace %p with other pointer types
>       kprobes/x86: Fix %p uses in error messages
>       kprobes/arm: Fix %p uses in error messages
>       kprobes/arm64: Fix %p uses in error messages
> 
> 
>  arch/arm/probes/kprobes/core.c      |   10 ++++----
>  arch/arm/probes/kprobes/test-core.c |    1 -
>  arch/arm64/kernel/probes/kprobes.c  |    4 ++-
>  arch/x86/kernel/kprobes/core.c      |   12 +++------
>  kernel/kprobes.c                    |   46 ++++++++++++++++++++++-------------
>  5 files changed, 40 insertions(+), 33 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
