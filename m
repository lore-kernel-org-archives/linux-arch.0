Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41032 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfHSR5C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 13:57:02 -0400
MIME-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
 <20190812215052.71840-13-ndesaulniers@google.com> <1566237106.8670clhnrk.naveen@linux.ibm.com>
In-Reply-To: <1566237106.8670clhnrk.naveen@linux.ibm.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 19 Aug 2019 19:56:47 +0200
Message-ID: <CA+icZUVc528uRJ7SPcnzzZQuomdGGOE6+BFPPyRSUpFP2J+Lnw@mail.gmail.com>
Subject: Re: [PATCH 13/16] include/asm-generic: prefer __section from compiler_attributes.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: akpm@linux-foundation.org, Nick Desaulniers <ndesaulniers@google.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, jpoimboe@redhat.com, Martin KaFai Lau <kafai@fb.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, netdev@vger.kernel.org, Song Liu <songliubraving@fb.com>, yhs@fb.com
Message-ID: <20190819175647.z8S-xoGGXhAR-i_TTk7Dg9fGWy4Z96hbF4RXoe7VSbk@z>

On Mon, Aug 19, 2019 at 7:52 PM Naveen N. Rao
<naveen.n.rao@linux.ibm.com> wrote:
>
> Nick Desaulniers wrote:
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> [ Linux v5.3-rc5 ]

Patchset "for-5.3/x86-section-name-escaping":

include/linux/compiler.h: remove unused KENTRY macro
include/linux: prefer __section from compiler_attributes.h
include/asm-generic: prefer __section from compiler_attributes.h
x86: prefer __section from compiler_attributes.h

- Sedat -
