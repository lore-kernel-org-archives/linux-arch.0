From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH 13/16] include/asm-generic: prefer __section from compiler_attributes.h
Date: Mon, 19 Aug 2019 19:56:47 +0200
Message-ID: <CA+icZUVc528uRJ7SPcnzzZQuomdGGOE6+BFPPyRSUpFP2J+Lnw@mail.gmail.com>
References: <20190812215052.71840-1-ndesaulniers@google.com>
 <20190812215052.71840-13-ndesaulniers@google.com> <1566237106.8670clhnrk.naveen@linux.ibm.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566237106.8670clhnrk.naveen@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: akpm@linux-foundation.org, Nick Desaulniers <ndesaulniers@google.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, jpoimboe@redhat.com, Martin KaFai Lau <kafai@fb.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, netdev@vger.kernel.org, Song Liu <songliubraving@fb.com>, yhs@fb.com
List-Id: linux-arch.vger.kernel.org

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
