From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 04/17] Documentation: atomic_ops.txt is core-api/atomic_ops.rst
Date: Wed, 7 Jun 2017 09:19:17 +0200
Message-ID: <CAMuHMdVnTHhaL5RtWfjhF7nAkH4QNsfyRtr64HPpE_W7pJwctQ@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-5-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170606230007.19101-5-palmer@dabbelt.com>
Sender: linux-doc-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

CC doc folks

On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> I was reading the memory barries documentation in order to make sure the
> RISC-V barries were correct, and I found a broken link to the atomic
> operations documentation.
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  Documentation/memory-barriers.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 732f10ea382e..f1c9eaa45a57 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -498,11 +498,11 @@ And a couple of implicit varieties:
>       This means that ACQUIRE acts as a minimal "acquire" operation and
>       RELEASE acts as a minimal "release" operation.
>
> -A subset of the atomic operations described in atomic_ops.txt have ACQUIRE
> -and RELEASE variants in addition to fully-ordered and relaxed (no barrier
> -semantics) definitions.  For compound atomics performing both a load and a
> -store, ACQUIRE semantics apply only to the load and RELEASE semantics apply
> -only to the store portion of the operation.
> +A subset of the atomic operations described in core-api/atomic_ops.rst have
> +ACQUIRE and RELEASE variants in addition to fully-ordered and relaxed (no
> +barrier semantics) definitions.  For compound atomics performing both a load
> +and a store, ACQUIRE semantics apply only to the load and RELEASE semantics
> +apply only to the store portion of the operation.
>
>  Memory barriers are only required where there's a possibility of interaction
>  between two CPUs or between a CPU and a device.  If it can be guaranteed that
> --
> 2.13.0
