Return-Path: <robh@kernel.org>
MIME-Version: 1.0
References: <cover.1581497860.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 13 Feb 2020 17:47:14 -0600
Message-ID: <CAL_JsqJeXJ6zWvEUi=gyOV0eCcXsvNmkK9EstC9hg9AKfMXnKw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Hi,
Content-Type: text/plain; charset="UTF-8"
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Borislav Petkov <bp@suse.de>, Cornelia Huck <cohuck@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greg Ungerer <gerg@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mike Rapoport <rppt@linux.ibm.com>, Mubin Sayyed <mubinusm@xilinx.com>, Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>, Stefan Asserhall <stefan.asserhall@xilinx.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Will Deacon <will@kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200213234714.ObTKS-c3EFJ2w_UNa7-dn0ulk7PYNtcvjWxrH9CKW7I@z>

On Wed, Feb 12, 2020 at 2:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
>
> I am sending this series as before SMP support.
> Most of these patches are clean ups and should be easy to review them. I
> expect there will be more discussions about SMP support.

While not really related to adding SMP, any chance you or someone
could look at moving microblaze PCI support to drivers/pci/? I suspect
much of the code should drop out as we have common helpers for much of
it now. That would leave only powerpc and mips for DT+PCI platforms.

Rob
