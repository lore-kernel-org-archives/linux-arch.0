From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 00/11] arm64: untag user pointers passed to the kernel
Date: Thu, 30 Aug 2018 13:48:15 +0200
Message-ID: <CAAeHK+yyX95aBzzXRoSUYj1QF8c-7uwGNeuwfBU8zOjOWyO_Wg@mail.gmail.com>
References: <cover.1535629099.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrey Konovalov <andreyknvl@google.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@lin>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 30, 2018 at 1:41 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [1]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.
>
> This patch makes a few of the kernel interfaces accept tagged user
> pointers. The kernel is already able to handle user faults with tagged
> pointers and has the untagged_addr macro, which this patchset reuses.
>
> Thanks!
>
> [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
>
> Changes in v6:
> - Added annotations for user pointer casts found by sparse.

Hi Catalin,

I've added annotations for the user pointer casts pointed by the new
sparse flag -Wcast-from-as as you asked. I've used __force casts
instead of adding specialized macros.

There are also non annotated casts for other pointer types (iomem,
rcu) which are detected with the new flag, should I annotate those as
well?

I'm not sure though what value would that bring though, as there are
~3000 various sparse warnings produced with the default flags anyway.

WDYT?

Thanks!

[1] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
