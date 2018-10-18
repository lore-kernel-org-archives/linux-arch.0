From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 0/8] arm64: untag user pointers passed to the kernel
Date: Thu, 18 Oct 2018 18:33:31 +0100
Message-ID: <20181018173330.GG237391@arrakis.emea.arm.com>
References: <cover.1538485901.git.andreyknvl@google.com>
 <be684ce5-92fd-e970-b002-83452cf50abd@arm.com>
 <CAAeHK+yEZTLjgSj8YUzeJec9Pp2TwuLT5nCa1OpfBLXJkx_hhg@mail.gmail.com>
 <CAFKCwrh4-BvFB_R1J0LWcbfeR=d02OazowFuMU+hmq8Y=Dx+4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFKCwrh4-BvFB_R1J0LWcbfeR=d02OazowFuMU+hmq8Y=Dx+4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evgenii Stepanov <eugenis@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Linux Memory Management List <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Linux ARM <linux-arm->
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 17, 2018 at 01:25:42PM -0700, Evgenii Stepanov wrote:
> On Wed, Oct 17, 2018 at 7:20 AM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > On Wed, Oct 17, 2018 at 4:06 PM, Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >> I have been thinking a bit lately on how to address the problem of
> >> user tagged pointers passed to the kernel through syscalls, and
> >> IMHO probably the best way we have to catch them all and make sure
> >> that the approach is maintainable in the long term is to introduce
> >> shims that tag/untag the pointers passed to the kernel.
> >>
> >> In details, what I am proposing can live either in userspace
> >> (preferred solution so that we do not have to relax the ABI) or in
> >> kernel space and can be summarized as follows:
> >>  - A shim is specific to a syscall and is called by the libc when
> >>  it needs to invoke the respective syscall.
> >>  - It is required only if the syscall accepts pointers.
> >>  - It saves the tags of a pointers passed to the syscall in memory
> >>  (same approach if the we are passing a struct that contains
> >>  pointers to the kernel, with the difference that all the tags of
> >>  the pointers in the struct need to be saved singularly)
> >>  - Untags the pointers
> >>  - Invokes the syscall
> >>  - Retags the pointers with the tags stored in memory
> >>  - Returns
> >>
> >> What do you think?
> >
> > If I correctly understand what you are proposing, I'm not sure if that
> > would work with the countless number of different ioctl calls. For
> > example when an ioctl accepts a struct with a bunch of pointer fields.
> > In this case a shim like the one you propose can't live in userspace,
> > since libc doesn't know about the interface of all ioctls, so it can't
> > know which fields to untag. The kernel knows about those interfaces
> > (since the kernel implements them), but then we would need a custom
> > shim for each ioctl variation, which doesn't seem practical.
> 
> The current patchset handles majority of pointers in a just a few
> common places, like copy_from_user. Userspace shims will need to untag
> & retag all pointer arguments - we are looking at hundreds if not
> thousands of shims. They will also be located in a different code base
> from the syscall / ioctl implementations, which would make them
> impossible to keep up to date.

I think ioctls are a good reason not to attempt such user-space shim
layer (though it would have been much easier for the kernel ;)).

-- 
Catalin
