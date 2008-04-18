From: Benjamin Herrenschmidt <benh-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
Date: Fri, 18 Apr 2008 16:44:21 +1000
Message-ID: <1208501061.6958.394.camel@pasglop>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	 <20080413171953.bde5e9ac.akpm@linux-foundation.org>
	 <1208133506.6958.82.camel@pasglop>
	 <20080413191338.9776ebd0.akpm@linux-foundation.org>
	 <1208491086.6958.381.camel@pasglop>
	 <20080417211905.8ff769fa.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080417211905.8ff769fa.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, takata-TMSiXQfHlQjsTix1lMzHGQ@public.gmane.org, linux-m32r-rQhvJZKUsGBRYuoOT4C5/9i2O/JbrIOy@public.gmane.org, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> > so what
> > about the patch below ?
> 
> I like it, but the compiler won't ;)
> 
> > If you're ok, I'll re-send with appropriate sob
> > & adapted powerpc part.
> 
> Sure.
> 
> > +void __init __attribute__((weak) thread_info_cache_init(void)
> 
> s/weak)/weak))/

Yeah, missing quilt ref :-)

I'll send the proper patches in a minute.

Cheers,
Ben.
