Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfCVKsu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Mar 2019 06:48:50 -0400
Date: Fri, 22 Mar 2019 10:48:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 2/4] arm64: Define Documentation/arm64/elf_at_flags.txt
Message-ID: <20190322104839.GA13384@arrakis.emea.arm.com>
References: <cover.1552679409.git.andreyknvl@google.com>
 <20190318163533.26838-1-vincenzo.frascino@arm.com>
 <20190318163533.26838-3-vincenzo.frascino@arm.com>
 <CADGdYn7HYcj4vxw2bCS6McdNRmWu7o13=VAQra5A1Z18JNPMXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGdYn7HYcj4vxw2bCS6McdNRmWu7o13=VAQra5A1Z18JNPMXQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Kate Stewart <kstewart@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Kostya Serebryany <kcc@google.com>, Eric Dumazet <edumazet@google.com>, Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Graeme Barnes <Graeme.Barnes@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Dmitry Vyukov <dvyukov@google.com>, Branislav Rankov <Branislav.Rankov@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20190322104840.rfrCiOwzIfJM8hb9Bkfz0fhyiB51dXwNl9BBdp496Ng@z>

On Fri, Mar 22, 2019 at 11:52:37AM +0530, Amit Daniel Kachhap wrote:
> On Mon, Mar 18, 2019 at 10:06 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> > +Example of correct usage (pseudo-code) for a userspace application:
> > +
> > +bool arm64_syscall_tbi_is_present(void)
> > +{
> > +       unsigned long at_flags = getauxval(AT_FLAGS);
> > +       if (at_flags & ARM64_AT_FLAGS_SYSCALL_TBI)
> > +                       return true;
> > +
> > +       return false;
> > +}
> > +
> > +void main(void)
> > +{
> > +       char *addr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> > +                         MAP_ANONYMOUS, -1, 0);
> > +
> > +       int fd = open("test.txt", O_WRONLY);
> > +
> > +       /* Check if the relaxed ABI is supported */
> > +       if (arm64_syscall_tbi_is_present()) {
> > +               /* Add a tag to the pointer */
> > +               addr = tag_pointer(addr);
> > +       }
> > +
> > +       strcpy("Hello World\n", addr);
> 
> Nit: s/strcpy("Hello World\n", addr)/strcpy(addr, "Hello World\n")

Not exactly a nit ;).

> > +
> > +       /* Write to a file */
> > +       write(fd, addr, sizeof(addr));

I presume this was supposed to write "Hello World\n" to a file but
sizeof(addr) is 1.

Since we already support tagged pointers in user space (as long as they
are not passed into the kernel), the above example could tag the pointer
unconditionally and only clear it before write() if
!arm64_syscall_tbi_is_present().

-- 
Catalin
