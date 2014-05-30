From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 02/32] uapi: add struct __kernel_timespec{32,64}
Date: Fri, 30 May 2014 13:18:45 -0700
Message-ID: <5388E7A5.90308@zytor.com>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de> <1401480116-1973111-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401480116-1973111-3-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/30/2014 01:01 PM, Arnd Bergmann wrote:
> We cannot use time_t or any derived structures beyond the year
> 2038 in interfaces between kernel and user space, on 32-bit
> machines.
> 
> This is my suggestion for how to migrate syscall and ioctl
> interfaces: We completely phase out time_t, timeval and timespec
> from the uapi header files and replace them with types that are
> either explicitly safe (__kernel_timespec64), or explicitly
> unsafe (e.g. __kernel_timespec32). For each unsafe interface,
> there needs to be a safe replacement interface.
> 

This gets really messy for structures where this is ABI-dependent.  I'm
not sure this is a net win.

> +/*
> + * __kernel_timespec64 is the general type to be used for
> + * new user space interfaces passing a time argument.
> + * 64-bit nanoseconds is a bit silly, but the advantage is
> + * that it is compatible with the native 'struct timespec'
> + * on 64-bit user space. This simplifies the compat code.
> + */
> +struct __kernel_timespec64 {
> +	long long tv_sec;
> +	long long tv_nsec;
> +};

So it seems that it is not just POSIX that is drain bramaged with this,
but the "long" type for tv_nsec idiocy has made it into the C11
standard.  This unfortunately means that now there are two standards
bodies involved, at least one of which moves very slowly.

This makes me wonder if we don't need to deal with the problem in the
case of 32-bit ABIs with 64-bit time_t.  The logical thing seems to be
to EITHER:

a. ALWAYS ignore the upper 32 bits of tv_nsec when read from user space,
   but always set them to zero, or
b. Only ignore the upper 32 bits of tv_nsec when we are known to come
   from a 32-bit ABI context, but still always return zero.  These bits
   are already only used for validity checking.

   This most likely introduces a whole lot of new tests in deep paths,
   although we probably can centralize this in a single function, which
   otherwise ends up looking a lot like compat_get_timespec().

Getting rid of struct timespec on the kernel/user boundary is probably
not really feasible.

	-hpa
