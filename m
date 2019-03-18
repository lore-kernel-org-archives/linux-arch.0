From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v11 08/14] net, arm64: untag user pointers in tcp_zerocopy_receive
Date: Mon, 18 Mar 2019 17:08:48 +0100
Message-ID: <CAAeHK+w+koPnKP2=3yQsj5wCVY-c6+NLBnkKWQP8Q6M6pzO4dA@mail.gmail.com>
References: <cover.1552679409.git.andreyknvl@google.com> <56d3373c1c5007d776fcd5de4523f4b9da341fb6.1552679409.git.andreyknvl@google.com>
 <04c5b2de-7fde-7625-9d42-228160879ea0@gmail.com> <CAAeHK+xXLypBpF1EE73KuzQAo0E6Y=apS46wo+swo2AB6cy3YA@mail.gmail.com>
 <CAAeHK+yxcG=KBjG0A5BicBA7Zwu6LR6t=g5b-9EAPXA8_Dfm2g@mail.gmail.com> <CANn89iJfjhNcDS_eHg-OUiGui-hyRL5iWQuu_U+BW_N9iSNbeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CANn89iJfjhNcDS_eHg-OUiGui-hyRL5iWQuu_U+BW_N9iSNbeA@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Eric Dumazet <edumazet@google.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.o>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 18, 2019 at 3:45 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Mar 18, 2019 at 6:17 AM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
>
> > Looking at the code, what's the point of this address != zc->address
> > check? Should I just remove it?
>
> No you must not remove it.
>
> The test detects if a u64 ->unsigned long  conversion might have truncated bits.
>
> Quite surprisingly some people still use 32bit kernels.
>
> The ABI is 64bit only, because we did not want to have yet another compat layer.
>
> struct tcp_zerocopy_receive {
>     __u64 address; /* in: address of mapping */
>     __u32 length; /* in/out: number of bytes to map/mapped */
>     __u32 recv_skip_hint; /* out: amount of bytes to skip */
> };

Ah, got it, thanks! I'll add a comment here then, otherwise this looks
confusing.
