From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 16/31] arm64: ELF definitions
Date: Thu, 16 Aug 2012 12:37:53 +0000
Message-ID: <201208161237.53594.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <201208151415.39570.arnd@arndb.de> <20120816102300.GG31784@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120816102300.GG31784@mudshark.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 16 August 2012, Will Deacon wrote:
> > This looks wrong: PER_LINUX/PER_LINUX32 decides over the output of the
> > uname system call, while TIF_32BIT decides over the instruction set
> > when returning to user space. You definitely should not set the personality
> > to the value you pass from the elf loader. Instead, just do
> > 
> > #define SET_PERSONALITY(ex) clear_thread_flag(TIF_32BIT);
> > #defined COMPAT_SET_PERSONALITY(ex) set_thread_flag(TIF_32BIT);
> 
> In this case, won't uname be incorrect (aarch64l) for aarch32 tasks (which
> expect something like armv8l)?

No, the uname output is meant to tell you about the system, not the
instruction set that you are using (you already know that in compiled
code).

The main use case is to fool stuff like autoconf into assuming your
architecture is the other one, e.g. when building a 32 bit package
on using a 64 bit /bin/bash to run ./configure or vice versa.

	Arnd
