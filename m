From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 02/19] csky: Exception handling and syscall
Date: Mon, 19 Mar 2018 09:50:09 +0100
Message-ID: <20180319085009.GA32603@isilmar-4.linta.de>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

> +#define __ARCH_WANT_SYSCALL_DEPRECATED
> +#define __ARCH_WANT_SYSCALL_OFF_T
> +#define __ARCH_WANT_SYSCALL_NO_AT
> +#define __ARCH_WANT_SYSCALL_NO_FLAGS

Does this arch *really* want these deprecated and obsolete syscalls? See the
commend in include/uapi/asm-generic/unistd.h

 * All syscalls below here should go away really,
 * these are provided for both review and as a porting
 * help for the C library version.

Thanks,
	Dominik
