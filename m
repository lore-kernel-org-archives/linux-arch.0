From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
Date: Thu, 15 Mar 2018 06:37:49 -0500
Message-ID: <87o9jpbmcy.fsf@xmission.com>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
        <20180314144614.1632190-2-arnd@arndb.de> <87po45hcuy.fsf@xmission.com>
        <CAK8P3a1GL2N=emTbSgNGHxOrXtG6BxqRGMg00-tZqKg6-0O5=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1GL2N=emTbSgNGHxOrXtG6BxqRGMg00-tZqKg6-0O5=w@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 15 Mar 2018 11:48:12 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thu, Mar 15, 2018 at 11:06 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>>> The frv, tile and blackfin architectures are being removed, so
>>> we can clean up this header by removing all the special cases
>>> except those for ia64.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  include/uapi/asm-generic/siginfo.h | 36 ++----------------------------------
>>>  1 file changed, 2 insertions(+), 34 deletions(-)
>>>
>>
>> If I am reading siginfo.h correctly after this cleanup patch
>> we can perform another cleanup and unconditionally define
>> all of the ia64 si_codes except for __SEGV_PSTKOVF which
>> aliases SEGV_PKUERR.
>>
>> Which has the advantage that no one is tempted to define any further
>> aliased si_codes.
>
> Do you mean like this:
>
> diff --git a/include/uapi/asm-generic/siginfo.h
> b/include/uapi/asm-generic/siginfo.h
> index b2ebf16c391a..ff13ed50dde8 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -186,11 +186,9 @@ typedef struct siginfo {
>  #define ILL_PRVREG     6       /* privileged register */
>  #define ILL_COPROC     7       /* coprocessor error */
>  #define ILL_BADSTK     8       /* internal stack error */
> -#ifdef __ia64__
> -# define ILL_BADIADDR  9       /* unimplemented instruction address */
> -# define __ILL_BREAK   10      /* illegal break */
> -# define __ILL_BNDMOD  11      /* bundle-update (modification) in progress */
> -#endif
> +#define ILL_BADIADDR   9       /* unimplemented instruction address */
> +#define __ILL_BREAK    10      /* illegal break */
> +#define __ILL_BNDMOD   11      /* bundle-update (modification) in progress */
>  #define NSIGILL                11
>
>  /*
> @@ -204,13 +202,11 @@ typedef struct siginfo {
>  #define FPE_FLTRES     6       /* floating point inexact result */
>  #define FPE_FLTINV     7       /* floating point invalid operation */
>  #define FPE_FLTSUB     8       /* subscript out of range */
> -#ifdef __ia64__
> -# define __FPE_DECOVF  9       /* decimal overflow */
> -# define __FPE_DECDIV  10      /* decimal division by zero */
> -# define __FPE_DECERR  11      /* packed decimal error */
> -# define __FPE_INVASC  12      /* invalid ASCII digit */
> -# define __FPE_INVDEC  13      /* invalid decimal digit */
> -#endif
> +#define __FPE_DECOVF   9       /* decimal overflow */
> +#define __FPE_DECDIV   10      /* decimal division by zero */
> +#define __FPE_DECERR   11      /* packed decimal error */
> +#define __FPE_INVASC   12      /* invalid ASCII digit */
> +#define __FPE_INVDEC   13      /* invalid decimal digit */
>  #define NSIGFPE                13
>
>  /*
>
> That seems reasonable. If you send me a patch with a proper
> changelog (I don't think I could explain this well enough), I'll
> add it to the series.

Yes.

I just realized you can also remove the #ifdefs for BUS_MCEERR_AR,
BUS_MCEERR_AO, and SEGV_BNDERR.  As those si_codes are now always
defined.  That description I expect you can handle.

For a description of the above change how does this sound?

Unlike system call numbers the assignment of si_codes has never had a
reason to be made per architecture.  Some architectures have had unique
conditions to report and reporting those conditions needed new si_codes.
Nothing has ever needed si_codes to have different values on different
architectures.  The si_code space is vast so even with defining all
si_codes on all architectures there is no danger in running out of
si_code values.

The history of the si_codes BUS_MCEERR_AR, BUS_MCEER_AO, SEGV_BNDERR,
and SEGV_PKUERR show that a need of one architecture frequently becomes
a need of another architecture which makes sharing si_codes between
architectures a positive benefit and something to be encouraged.

Where there are no conflicts with the historical ia64 arch specific
si_codes and any other si_codes make them generic si_codes.  We might
need them on another architecture someday.

This leaves only the good example of arch generic si_codes in the kernel
for future architectures and architecture enhancments to follow.
Without bad examples to follow it should be easy to avoid the mistakes
of the past.

Eric
