From: Vineet Gupta <vineetg76@gmail.com>
Subject: Portable assmbler code - newline (was Re: [PATCH] kernel/modsign_certificate.S:
 use real contents instead of macro GLOBAL())
Date: Thu, 24 Oct 2013 22:58:56 +0530
Message-ID: <526958D8.6030102@synopsys.com>
References: <523FD9E7.3050303@asianux.com>	<523FDBD7.4040602@asianux.com>	<C2D7FE5348E1B147BCA15975FBA2307514DED9@IN01WEMBXA.internal.synopsys.com>	<523FE578.5060801@asianux.com>	<52672DAC.1030307@asianux.com>	<CAMqJFCou4SObPni5Lb_tX=0hQ__kF_9MLDC-6a1opptc9dxT-A@mail.gmail.com>	<52673E41.6040606@asianux.com>	<5267AF98.1010800@asianux.com>	<5268B0B1.9050009@asianux.com> <CAFLxGvzERDqwZhb_5d=bXKmqz6-Yrema_TLMTM7rjyeFeDJG_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:58162 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab3JXR3B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2013 13:29:01 -0400
In-Reply-To: <CAFLxGvzERDqwZhb_5d=bXKmqz6-Yrema_TLMTM7rjyeFeDJG_w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard.weinberger@gmail.com>, Chen Gang <gang.chen@asianux.com>
Cc: Joern Rennecke <joern.rennecke@embecosm.com>, James Hogan <james.hogan@imgtec.com>, Rusty Russell <rusty@rustcorp.com.au>, Takashi Iwai <tiwai@suse.de>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "jeremy.bennett@embecosm.com" <jeremy.bennett@embecosm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>, Francois Bedard <Francois.Bedard@synopsys.com>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

+CC linux-arch

On 10/24/2013 11:33 AM, Richard Weinberger wrote:
> On Thu, Oct 24, 2013 at 7:31 AM, Chen Gang <gang.chen@asianux.com> wrote:
>> > For some architectures, tool chain is not smart enough to recognize the
>> > macro with multiple lines (e.g. arc tool chain), and for common ".S"
>> > file, this kind of macro is also rarely used.
> Does not "not smart enough" mean than the said toolchain is broken/buggy
> or is the kernel using an unsupported notation?
> 

IMHO this is not broken - rather the code is not fully portable - given that gas
ports of arches have differnet notions of what to treat as comment and what newline.

Looking as binutils/gas/config, I can see that avr, cris,...are likely broken in
the same way as ARC is.

Historically ARC has had ';' as comment char, which Joern relatively recently
augmented to have '#' as well. However there's legacy codebase which relies on ';'
being a comment and we can't change that fact.

So can we introduce an ARCH over-ridable newline annotation in linkage.h and other
places after auditing. Since asm/linkage.h preempts linux/linkage.h by way of
#include it shd be pretty strightforward.

Something like below. I can send the formal patch if people think the approach is OK.


----------------->
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index d3e8ad23a8e0..4188c632f2b8 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -6,6 +6,10 @@
 #include <linux/export.h>
 #include <asm/linkage.h>

+#ifndef __ARCH_NL
+#define __ARCH_NL
+#endif
+
 #ifdef __cplusplus
 #define CPP_ASMLINKAGE extern "C"
 #else
@@ -75,7 +79,7 @@

 #ifndef ENTRY
 #define ENTRY(name) \
-  .globl name; \
+  .globl name; __ARCH_NL \
   ALIGN; \
   name:
 #endif
@@ -83,7 +87,7 @@

 #ifndef WEAK
 #define WEAK(name)        \
-       .weak name;        \
+       .weak name; __ARCH_NL \
        name:
 #endif
