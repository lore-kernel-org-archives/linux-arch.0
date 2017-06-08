From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: CPU_BIG_ENDIAN in generic code
Date: Thu, 8 Jun 2017 16:36:58 +0200
Message-ID: <CAK8P3a2JDEQ+KjajVUhFbbfHmM+8AdkEzbJwretar78PsfOAKA@mail.gmail.com>
References: <877f0z6oig.fsf@concordia.ellerman.id.au> <28d6c874-4653-b15d-39b7-57a032abc9c6@oracle.com>
 <CAK8P3a1WfU9V1k2r=TfJSVRTymuD8n2hkJDr6u1KcmC_scAZMA@mail.gmail.com> <20170608.100222.1573468093040905016.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608.100222.1573468093040905016.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: Babu Moger <babu.moger@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 8, 2017 at 4:02 PM, David Miller <davem@davemloft.net> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 8 Jun 2017 10:01:59 +0200
>
>> I would also suggest adding a sanity check like
>
> Hmm, but this will kill the build for non-fixed endian architectures
> won't it?

I think only xtensa, all others already define CONFIG_CPU_BIG_ENDIAN
conditionally, and include the right header depending on that.

For xtensa, the decision is apparently made by the toolchain, and the
kernel just detects the macros set by the compiler, but that is slightly
fragile because it prevents us from making Kconfig decisions based on
endianess.

       Arnd
