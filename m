From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
Date: Thu, 15 Mar 2018 11:48:12 +0100
Message-ID: <CAK8P3a1GL2N=emTbSgNGHxOrXtG6BxqRGMg00-tZqKg6-0O5=w@mail.gmail.com>
References: <20180314143529.1456168-1-arnd@arndb.de> <20180314144614.1632190-1-arnd@arndb.de>
 <20180314144614.1632190-2-arnd@arndb.de> <87po45hcuy.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87po45hcuy.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 15, 2018 at 11:06 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> The frv, tile and blackfin architectures are being removed, so
>> we can clean up this header by removing all the special cases
>> except those for ia64.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  include/uapi/asm-generic/siginfo.h | 36 ++----------------------------------
>>  1 file changed, 2 insertions(+), 34 deletions(-)
>>
>
> If I am reading siginfo.h correctly after this cleanup patch
> we can perform another cleanup and unconditionally define
> all of the ia64 si_codes except for __SEGV_PSTKOVF which
> aliases SEGV_PKUERR.
>
> Which has the advantage that no one is tempted to define any further
> aliased si_codes.

Do you mean like this:

diff --git a/include/uapi/asm-generic/siginfo.h
b/include/uapi/asm-generic/siginfo.h
index b2ebf16c391a..ff13ed50dde8 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -186,11 +186,9 @@ typedef struct siginfo {
 #define ILL_PRVREG     6       /* privileged register */
 #define ILL_COPROC     7       /* coprocessor error */
 #define ILL_BADSTK     8       /* internal stack error */
-#ifdef __ia64__
-# define ILL_BADIADDR  9       /* unimplemented instruction address */
-# define __ILL_BREAK   10      /* illegal break */
-# define __ILL_BNDMOD  11      /* bundle-update (modification) in progress */
-#endif
+#define ILL_BADIADDR   9       /* unimplemented instruction address */
+#define __ILL_BREAK    10      /* illegal break */
+#define __ILL_BNDMOD   11      /* bundle-update (modification) in progress */
 #define NSIGILL                11

 /*
@@ -204,13 +202,11 @@ typedef struct siginfo {
 #define FPE_FLTRES     6       /* floating point inexact result */
 #define FPE_FLTINV     7       /* floating point invalid operation */
 #define FPE_FLTSUB     8       /* subscript out of range */
-#ifdef __ia64__
-# define __FPE_DECOVF  9       /* decimal overflow */
-# define __FPE_DECDIV  10      /* decimal division by zero */
-# define __FPE_DECERR  11      /* packed decimal error */
-# define __FPE_INVASC  12      /* invalid ASCII digit */
-# define __FPE_INVDEC  13      /* invalid decimal digit */
-#endif
+#define __FPE_DECOVF   9       /* decimal overflow */
+#define __FPE_DECDIV   10      /* decimal division by zero */
+#define __FPE_DECERR   11      /* packed decimal error */
+#define __FPE_INVASC   12      /* invalid ASCII digit */
+#define __FPE_INVDEC   13      /* invalid decimal digit */
 #define NSIGFPE                13

 /*

That seems reasonable. If you send me a patch with a proper
changelog (I don't think I could explain this well enough), I'll
add it to the series.

      Arnd
