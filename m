From: Andy Lutomirski <luto@MIT.EDU>
Subject: Re: [PATCH 30/30] x32: Add x32 VDSO support
Date: Mon, 20 Feb 2012 16:12:33 -0800
Message-ID: <4F42E171.9080005@mit.edu>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <1329696488-16970-31-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329696488-16970-31-git-send-email-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com
List-Id: linux-arch.vger.kernel.org

On 02/19/2012 04:08 PM, H. Peter Anvin wrote:
> From: "H. J. Lu" <hjl.tools@gmail.com>
> 
> Add support for the x32 VDSO.  The x32 VDSO takes advantage of the
> similarity between the x86-64 and the x32 ABIs to contain the same
> content, only the container is different, as the x32 VDSO obviously is
> an x32 shared object.

> +
> +/*
> + * This controls what userland symbols we export from the vDSO.
> + */
> +VERSION {
> +	LINUX_2.6 {
> +	global:
> +		clock_gettime;
> +		__vdso_clock_gettime;
> +		gettimeofday;
> +		__vdso_gettimeofday;
> +		getcpu;
> +		__vdso_getcpu;
> +		time;
> +		__vdso_time;
> +	local: *;
> +	};
> +}
> +

Would it make sense to remove the non-__vdso-prefixed weak symbols?
AFAICT they are somewhere between useless (because the __vdso symbols
are unambiguous), confusing (has anyone not read this and said "huh?"),
and wrong (they are not interchangeable with glibc's symbols as they
return different values).

We're stuck with them on x86-64, but x32 is new and has no
backwards-compatibility issues.

--Andy
