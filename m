Return-Path: <SRS0=HZcf=3N=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41794 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388378AbgAXRo2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 12:44:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so3240431eds.8
        for <linux-arch@vger.kernel.org>; Fri, 24 Jan 2020 09:44:27 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a9sm93588edm.82.2020.01.24.09.44.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 09:44:26 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id w15so3017345wru.4
        for <linux-arch@vger.kernel.org>; Fri, 24 Jan 2020 09:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com> <20200124082443.GY14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200124082443.GY14914@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Jan 2020 09:36:54 -0800
Message-ID: <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20200124173654.wFseOBK06_TbdSVY5p4i1hDXMokMaBDF8Z3rHOdXq34@z>

On Fri, Jan 24, 2020 at 12:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Just for curiosity's sake. What does clang actually do in that case?

This shouldn't necessarily be clang-specific. If the variable itself
is 'const', it might go into a read-only section. So trying to modify
it will quite possibly hit a SIGSEGV in user space (and in kernel
space cause an oops).

Note that that is different from a const pointer to something that
wasn't originally const. That's just a "error out at compile time if
somebody tries to write through it", but the const'ness can be cast
away, because all the 'const' really said was that the object can't be
modified through _that_ pointer, not in general.

(That also means that the compiler can't necessarily even optimize
multiple accesses through a const pointer away, because the object
might be modified through another pointer that aliases the const one -
you'd need to also mark it "restrict" to tell the compiler that no
other pointer will alias).

                 Linus
