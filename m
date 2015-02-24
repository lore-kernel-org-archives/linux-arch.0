From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: nios2: is the ptrace ABI correct?
Date: Tue, 24 Feb 2015 20:25:39 +0100
Message-ID: <10088870.tldQegtTla@wuerfel>
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com> <5636312.0WGrbVlVgB@wuerfel> <54EC98A9.9080203@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EC98A9.9080203@vanguardiasur.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Tobias Klauser <tklauser@distanz.ch>, Chung-Ling Tang <cltang@codesourcery.com>, Walter Goossens <waltergoossens@home.nl>, Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tuesday 24 February 2015 12:28:41 Ezequiel Garcia wrote:
> 
> Gah, no, you are right. I got confused.
> 
> So it would be OK to avoid remove pt_regs from the uapi headers?
> How does this affect the signal handling nios2 implementation?
> 

We have a number of architectures that don't provide this structure:

$ git grep -L pt_regs arch/*/include/uapi/asm/ptrace.h
arch/frv/include/uapi/asm/ptrace.h
arch/metag/include/uapi/asm/ptrace.h
arch/openrisc/include/uapi/asm/ptrace.h
arch/s390/include/uapi/asm/ptrace.h

so I'd assume it's ok in general not to have it. However, on
nios2, struct pt_regs is embedded inside of struct sigcontext.
If I read the code in arch/nios2/kernel/signal.c correctly,
this is actually a bug and you should use a different structure
there too, because pt_regs does not match the layout of the
stack either. This means that the (rare) user programs that
would know about the architecture to modify signal stacks
are currently broken.

	Arnd
