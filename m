From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/16] include/asm-generic: prefer __section from compiler_attributes.h
Date: Tue, 13 Aug 2019 09:57:20 +0200
Message-ID: <CAK8P3a2fSKT7AJXwfKQOJ5N3=NtwMOCw_5tuD+oOsmh2g-Kokw@mail.gmail.com>
References: <20190812215052.71840-1-ndesaulniers@google.com> <20190812215052.71840-13-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190812215052.71840-13-ndesaulniers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, sedat.dilek@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>, Yonghong Song <yhs@fb.com>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, clang-built-linux <clang-built-linux@googlegroups.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 12, 2019 at 11:52 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

The patch looks fine, but it looks like you forgot to add a description.

       Arnd
