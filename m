From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v7 0/8] arm64: untag user pointers passed to the kernel
Date: Wed, 17 Oct 2018 16:20:41 +0200
Message-ID: <CAAeHK+yEZTLjgSj8YUzeJec9Pp2TwuLT5nCa1OpfBLXJkx_hhg@mail.gmail.com>
References: <cover.1538485901.git.andreyknvl@google.com> <be684ce5-92fd-e970-b002-83452cf50abd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be684ce5-92fd-e970-b002-83452cf50abd@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 17, 2018 at 4:06 PM, Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> Hi Andrey,
> I have been thinking a bit lately on how to address the problem of user t=
agged pointers passed to the kernel through syscalls, and IMHO probably the=
 best way we have to catch them all and make sure that the approach is main=
tainable in the long term is to introduce shims that tag/untag the pointers=
 passed to the kernel.
>
> In details, what I am proposing can live either in userspace (preferred s=
olution so that we do not have to relax the ABI) or in kernel space and can=
 be summarized as follows:
>  - A shim is specific to a syscall and is called by the libc when it need=
s to invoke the respective syscall.
>  - It is required only if the syscall accepts pointers.
>  - It saves the tags of a pointers passed to the syscall in memory (same =
approach if the we are passing a struct that contains pointers to the kerne=
l, with the difference that all the tags of the pointers in the struct need=
 to be saved singularly)
>  - Untags the pointers
>  - Invokes the syscall
>  - Retags the pointers with the tags stored in memory
>  - Returns
>
> What do you think?

Hi Vincenzo,

If I correctly understand what you are proposing, I'm not sure if that
would work with the countless number of different ioctl calls. For
example when an ioctl accepts a struct with a bunch of pointer fields.
In this case a shim like the one you propose can't live in userspace,
since libc doesn't know about the interface of all ioctls, so it can't
know which fields to untag. The kernel knows about those interfaces
(since the kernel implements them), but then we would need a custom
shim for each ioctl variation, which doesn't seem practical.

Thanks!
