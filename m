From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86: Wire up 32-bit direct socket calls
Date: Mon, 07 Sep 2015 14:53:12 +0200
Message-ID: <3193269.4TGcgnGPrm@wuerfel>
References: <cb5138299d37d5800e2d135b01a7667fa6115854.1436912629.git.luto@kernel.org> <CAMuHMdXKA_+JY2ryf-yoJxQnbW=jsOjj_w2-Nsybpx0310neDA@mail.gmail.com> <55E75913.5050605@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <55E75913.5050605@zytor.com>
Sender: netdev-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Network Development <netdev@vger.kernel.org>, Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Larsson <alexl@redhat.com>, Cosimo Cecchi <cosimo@endlessm.com>, Dan Nicholson <nicholson@endlessm.com>, libc-alpha <libc-alpha@sourceware.org>, Rajalakshmi Srinivasaraghavan <raji@linux.vnet.ibm.com>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wednesday 02 September 2015 13:16:19 H. Peter Anvin wrote:
> On 09/02/2015 02:48 AM, Geert Uytterhoeven wrote:
> > 
> > Should all other architectures follow suit?
> > Or should we follow the s390 approach:
> > 
> 
> It is up to the maintainer(s), largely dependent on how likely you are
> going to want to support this in your libc, but in general, socketcall
> is an abomination which there is no reason not to bypass.
> 
> So follow suit unless you have a strong reason not to.

+1

In my y2038 syscall series, I'm adding a new recvmmsg64 call, and
we may decide to add new setsockopt/getsockopt variants as well.
This is probably not the last change to socketcall, and it would
be made much easier if all architectures had separate calls here.

It seems that there are very few architectures that don't already have
the separate calls:

$ git grep -l __NR_socketcall arch/*/include/uapi  | xargs git grep -L recvmsg 
arch/cris/include/uapi/asm/unistd.h
arch/frv/include/uapi/asm/unistd.h
arch/m32r/include/uapi/asm/unistd.h
arch/m68k/include/uapi/asm/unistd.h
arch/mn10300/include/uapi/asm/unistd.h
arch/s390/include/uapi/asm/unistd.h

These are of course all examples of architectures that originally followed
the i386 syscall scheme closely rather than trying to leave out obsolete
calls.

	Arnd
