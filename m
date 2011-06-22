From: NamJae Jeon <linkinjeon@gmail.com>
Subject: [PATCH] include : compile warning by __const_hweight8
Date: Wed, 22 Jun 2011 20:42:41 +0900
Message-ID: <BANLkTinTy6Dg0bwRANJjQsp8XEasqYc5vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hello, Arnd.

I make a patch again. Would you check this patch ?

Thanks.

=46rom 28589ea9aabb080020ab3c79adcecad5d7315f39 Mon Sep 17 00:00:00 200=
1
=46rom: Namjae Jeon <linkinjeon@gmail.com>
Date: Tue, 21 Jun 2011 14:39:03 +0900
Subject: [PATCH] include : compile warning by __const_hweight8

 compilation warning is caused by __const_hweight8 when using
hweight_long with -Wsign-compare option.
 you can see warning message like the following.

 include/linux/bitops.h: In function 'hweight_long':
 include/linux/bitops.h:49: warning: signed and unsigned type in
conditional expression

 The reason is that the default return value of this macro is signed.
So, need type casting to remove warning.

Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
---
 include/asm-generic/bitops/const_hweight.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/bitops/const_hweight.h
b/include/asm-generic/bitops/const_hweight.h
index fa2a50b..d91b1aa 100644
--- a/include/asm-generic/bitops/const_hweight.h
+++ b/include/asm-generic/bitops/const_hweight.h
@@ -4,7 +4,7 @@
 /*
  * Compile time versions of __arch_hweightN()
  */
-#define __const_hweight8(w)            \
+#define __const_hweight8(w) (unsigned long)    \
       (        (!!((w) & (1ULL << 0))) +       \
        (!!((w) & (1ULL << 1))) +       \
        (!!((w) & (1ULL << 2))) +       \
--
1.7.4-rc2

-----------------------------------------------------------------------=
----------------------------------------------------

2011/6/21 NamJae Jeon <linkinjeon@gmail.com>:
> Hello Arnd.
>
> I attached patch for this warning issue.
>
> If there is a problem of patch, plz reply ....
>
> Thanks.
>
>
> ---------------------------------------------------------------------=
-----------------------------------------------------------------
>
> From 28589ea9aabb080020ab3c79adcecad5d7315f39 Mon Sep 17 00:00:00 200=
1
> From: Namjae Jeon <linkinjeon@gmail.com>
> Date: Tue, 21 Jun 2011 14:39:03 +0900
> Subject: [PATCH] compilation warning is caused when using hweight_lon=
g
> with -Wsign-compare option.
> =A0Warning message is '
> =A0include/linux/bitops.h: In function 'hweight_long':
> =A0include/linux/bitops.h:49: warning: signed and unsigned type in
> conditional expression
> =A0The reason is that the default return value of this macro is signe=
d.
> So, need type casting to remove warning.
>
> Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
> ---
> =A0include/asm-generic/bitops/const_hweight.h | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/asm-generic/bitops/const_hweight.h
> b/include/asm-generic/bitops/const_hweight.h
> index fa2a50b..d91b1aa 100644
> --- a/include/asm-generic/bitops/const_hweight.h
> +++ b/include/asm-generic/bitops/const_hweight.h
> @@ -4,7 +4,7 @@
> =A0/*
> =A0* Compile time versions of __arch_hweightN()
> =A0*/
> -#define __const_hweight8(w) =A0 =A0 =A0 =A0 =A0 =A0\
> +#define __const_hweight8(w) (unsigned long) =A0 =A0\
> =A0 =A0 =A0 ( =A0 =A0 =A0 =A0(!!((w) & (1ULL << 0))) + =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0(!!((w) & (1ULL << 1))) + =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0(!!((w) & (1ULL << 2))) + =A0 =A0 =A0 \
> --
> 1.7.4-rc2
>
>
>
> ---------------------------------------------------------------------=
-----------------------------------------------------------------
> 2011/6/20 Arnd Bergmann <arnd@arndb.de>:
>> On Monday 20 June 2011, NamJae Jeon wrote:
>>> I found compile warning while compiling module when using -Wsign-co=
mpare option.
>>>
>>> include/linux/bitops.h: In function 'hweight_long':
>>> include/linux/bitops.h:49: warning: signed and unsigned type in
>>> conditional expression
>>>
>>> I found the reason of this problem that the default return value of
>>> the below macro is signed.
>>>
>>> #define __const_hweight8(w) =A0 =A0 =A0 =A0\
>>> =A0 =A0 =A0 ( (!!((w) & (1ULL << 0))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 1))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 2))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 3))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 4))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 5))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 6))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 7))) )
>>>
>>> So, I try to add (unsigned long) in __const_hweight8 like this.
>>>
>>> #define __const_hweight8(w) =A0 =A0 (unsigned long ) =A0 =A0 =A0 =A0=
\
>>> =A0 =A0 =A0 ( (!!((w) & (1ULL << 0))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 1))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 2))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 3))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 4))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 5))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 6))) + =A0 =A0 =A0 \
>>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 7))) )
>>>
>>> so, I can't see compile warning after fixing it, Would you plz chec=
k this ?
>>
>> Yes, this looks correct to me. Could you send the change as a proper=
 patch
>> with your Signed-off-by:?
>>
>> =A0 =A0 =A0 =A0Arnd
>>
>
