From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 06/24] kvm: provide kvm.h for all architecture: fixes
 headers_install
Date: Fri, 28 Mar 2008 14:40:46 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803281435090.14670@woody.linux-foundation.org>
References: <200803282115.m2SLFscm010265@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200803282115.m2SLFscm010265-AB4EexQrvXRQetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org



On Fri, 28 Mar 2008, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> 
> Currently include/linux/kvm.h is not considered by make headers_install,
> because Kbuild cannot handle " unifdef-$(CONFIG_FOO) += foo.h.  This problem
> was introduced by 040922c04cf2c8ac70be2e88a8a9614ecdb41d2e, which makes this
> an 2.6.25 regression.

That makes no sense. Commit 040922c04cf2c8ac70be2e88a8a9614ecdb41d2e is 
"include falloc.h in header-y", and seems to have nothing to do with 
kvm.h.

I absolutely detest how people put git commit SHA1's without any other 
information anyway, but this is a classic example of why you shouldn't do 
that: if somebody had actually bothered to look at what the SHA1 was, that 
person would probably have realized that the SHA1 was wrong.

So please - add the one-liner to all SHA1 ones, so that non-git people see 
what it is all about, and so that people who just read the commit log can 
make sense of it. And in trying to make sense of it, it can become obvious 
that it doesn't actually make any sense!

Of if the addition of falloc.h really _does_ matter, can somebody explain 
it to me?

		Linus
