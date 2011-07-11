From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 00/39] UAPI header file split [ver #2]
Date: Sun, 10 Jul 2011 21:38:27 -0700
Message-ID: <20110710213827.2779b0c3.rdunlap@xenotime.net>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:49498 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751143Ab1GKEi3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2011 00:38:29 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org, ralf@linux-mips.org

On Fri, 08 Jul 2011 15:22:45 +0100 David Howells wrote:

> 
> Here's my first installment of patches to clean up the kernel header files and

         or second

> sort out the recursion problems.  The planned steps are:

Could you give a small bit of background on the "recursion problems," please?


[snip]

>  (7) Provide a script to go through and rejig the #includes of each source file
>      to have just the ones that are actually required.

How is "actually required" defined?
We traditionally want to see #include <hdrfile> for any interfaces that are used,
even if other header files suck in some other needed header files.

>  (8) Provide a make target that tests all the KAPI and UAPI headers by simply
>      passing them one at a time to the compiler and attempting to compile them.

Interesting.

[snip]

>  (3) To eliminate the need for __KERNEL__.  After the split, __KERNEL__ can
>      certainly by unifdef'd from the residual kernel headers - but this isn't

                 be ?

>      quite true of the UAPI headers.

[snip]

> The uapi/ directories are also added with -I to the CPP flags after the
> include/ directories so that if the KAPI file does not exist, the UAPI file
> will be used directly.  This is not as elegant as using #include_next might be,
> but it does work.

Is this v2 patchset meant to avoid the use of #include_next?
I don't see that used, but patch 22 description refers to #include_next.

I'm still reviewing...

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
