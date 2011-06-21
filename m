From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: 'hweight_long' include/linux/bitops.h compile warning problem.
Date: Tue, 21 Jun 2011 15:11:47 +0900
Message-ID: <BANLkTimhGiXaru3a1_rgUeDL9RZ4vqHjpQ@mail.gmail.com>
References: <BANLkTi=ETn+LXtd20qkfcgrUngjqwVrVPg@mail.gmail.com>
	<201106201500.58617.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37834 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab1FUGLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2011 02:11:48 -0400
In-Reply-To: <201106201500.58617.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hello Arnd.

I attached patch for this warning issue.

If there is a problem of patch, plz reply ....

Thanks.


-----------------------------------------------------------------------=
---------------------------------------------------------------

=46rom 28589ea9aabb080020ab3c79adcecad5d7315f39 Mon Sep 17 00:00:00 200=
1
=46rom: Namjae Jeon <linkinjeon@gmail.com>
Date: Tue, 21 Jun 2011 14:39:03 +0900
Subject: [PATCH] compilation warning is caused when using hweight_long
with -Wsign-compare option.
 Warning message is '
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
---------------------------------------------------------------
2011/6/20 Arnd Bergmann <arnd@arndb.de>:
> On Monday 20 June 2011, NamJae Jeon wrote:
>> I found compile warning while compiling module when using -Wsign-com=
pare option.
>>
>> include/linux/bitops.h: In function 'hweight_long':
>> include/linux/bitops.h:49: warning: signed and unsigned type in
>> conditional expression
>>
>> I found the reason of this problem that the default return value of
>> the below macro is signed.
>>
>> #define __const_hweight8(w) =A0 =A0 =A0 =A0\
>> =A0 =A0 =A0 ( (!!((w) & (1ULL << 0))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 1))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 2))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 3))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 4))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 5))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 6))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 7))) )
>>
>> So, I try to add (unsigned long) in __const_hweight8 like this.
>>
>> #define __const_hweight8(w) =A0 =A0 (unsigned long ) =A0 =A0 =A0 =A0=
\
>> =A0 =A0 =A0 ( (!!((w) & (1ULL << 0))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 1))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 2))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 3))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 4))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 5))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 6))) + =A0 =A0 =A0 \
>> =A0 =A0 =A0 =A0 (!!((w) & (1ULL << 7))) )
>>
>> so, I can't see compile warning after fixing it, Would you plz check=
 this ?
>
> Yes, this looks correct to me. Could you send the change as a proper =
patch
> with your Signed-off-by:?
>
> =A0 =A0 =A0 =A0Arnd
>
