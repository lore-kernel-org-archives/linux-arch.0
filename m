From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 02/19] csky: Exception handling and syscall
Date: Mon, 19 Mar 2018 19:03:02 +0800
Message-ID: <20180319110302.GA15454@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
 <20180319085009.GA32603@isilmar-4.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180319085009.GA32603@isilmar-4.linta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi Dominik,

On Mon, Mar 19, 2018 at 09:50:09AM +0100, Dominik Brodowski wrote:
> > +#define __ARCH_WANT_SYSCALL_DEPRECATED
> > +#define __ARCH_WANT_SYSCALL_OFF_T
> > +#define __ARCH_WANT_SYSCALL_NO_AT
> > +#define __ARCH_WANT_SYSCALL_NO_FLAGS
> 
> Does this arch *really* want these deprecated and obsolete syscalls? See the
> commend in include/uapi/asm-generic/unistd.h
> 
>  * All syscalls below here should go away really,
>  * these are provided for both review and as a porting
>  * help for the C library version.
> 
OK, I will cleanup them next and check the unistd.h again.

Best Regards
  Guo Ren
