From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v11 13/14] arm64: update Documentation/arm64/tagged-pointers.txt
Date: Mon, 18 Mar 2019 17:59:04 +0100
Message-ID: <CAAeHK+yrAPOyuEyLCygrwQxCztb8P-9BBj-6RP6=iG-GGBkkQw@mail.gmail.com>
References: <cover.1552679409.git.andreyknvl@google.com> <bf0abceeaf32e6b9cdbc9dde45cc5966b5747ec4.1552679409.git.andreyknvl@google.com>
 <81bc3110-b638-4545-1270-26baec3d59e7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <81bc3110-b638-4545-1270-26baec3d59e7@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 18, 2019 at 2:26 PM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>
> On 15/03/2019 19:51, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > Document the ABI changes in Documentation/arm64/tagged-pointers.txt.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >   Documentation/arm64/tagged-pointers.txt | 18 ++++++++----------
> >   1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
> > index a25a99e82bb1..07fdddeacad0 100644
> > --- a/Documentation/arm64/tagged-pointers.txt
> > +++ b/Documentation/arm64/tagged-pointers.txt
> > @@ -17,13 +17,15 @@ this byte for application use.
> >   Passing tagged addresses to the kernel
> >   --------------------------------------
> >
> > -All interpretation of userspace memory addresses by the kernel assumes
> > -an address tag of 0x00.
> > +The kernel supports tags in pointer arguments (including pointers in
> > +structures) of syscalls, however such pointers must point to memory ranges
> > +obtained by anonymous mmap() or brk().
> >
> > -This includes, but is not limited to, addresses found in:
> > +The kernel supports tags in user fault addresses. However the fault_address
> > +field in the sigcontext struct will contain an untagged address.
> >
> > - - pointer arguments to system calls, including pointers in structures
> > -   passed to system calls,
> > +All other interpretations of userspace memory addresses by the kernel
> > +assume an address tag of 0x00, in particular:
> >
> >    - the stack pointer (sp), e.g. when interpreting it to deliver a
> >      signal,
> > @@ -33,11 +35,7 @@ This includes, but is not limited to, addresses found in:
> >
> >   Using non-zero address tags in any of these locations may result in an
> >   error code being returned, a (fatal) signal being raised, or other modes
> > -of failure.
> > -
> > -For these reasons, passing non-zero address tags to the kernel via
> > -system calls is forbidden, and using a non-zero address tag for sp is
> > -strongly discouraged.
> > +of failure. Using a non-zero address tag for sp is strongly discouraged.
>
> I don't understand why we should keep such a limitation. For MTE, tagging SP is
> something we are definitely considering. This does bother userspace software in some
> rare cases, but I'm not sure in what way it bothers the kernel.

I don't mind allowing tagged sp as well, but it seems that it's
another ABI relaxation that needs to be handled separately. I'm not
sure if we want to include that into this patchset, which is supposed
to allow tagged pointers to be passed to syscalls.

>
> Kevin
>
> >
> >   Programs maintaining a frame pointer and frame records that use non-zero
> >   address tags may suffer impaired or inaccurate debug and profiling
>
