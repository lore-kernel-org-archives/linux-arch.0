From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 00/39] UAPI header file split [ver #2]
Date: Thu, 14 Jul 2011 14:53:32 -0700
Message-ID: <4E1F655C.5040104@zytor.com>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:47698 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311Ab1GNVxo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Jul 2011 17:53:44 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org, ralf@linux-mips.org

On 07/08/2011 07:22 AM, David Howells wrote:
> 
> Here's my first installment of patches to clean up the kernel header files and
> sort out the recursion problems.  The planned steps are:
> 
>  (1) Split the Userspace API (UAPI) out of the kernel headers into its own
>      header directories.
> 
>  (2) Move stuff out of the Kernel API (KAPI) headers that can be contained in
>      individual directories as it is referenced by a single file or directory
>      of files.
> 
>  (3) Make coherent what can be found in commmon arch headers and disintegrate
>      asm/system.h.
> 
>  (4) Split some headers into definitions containers and inline function
>      containers to clean up recursion problems.  The main culprit is very
>      likely to be linux/sched.h, I think.
> 
>  (5) I'd like to split some headers (e.g. linux/security.h) to reduce the
>      conditional recompilation burden.  linux/security.h could have, for
>      instance, struct security_operations split out into a header file private
>      to the stuff in the security/ directory as the wrappers of its function
>      pointers are now out of lined in security/security.c.
> 
>  (6) Replace the traditional anti-reinclusion guards on header files with
>      three-state anti-recursion guards that abort compilation if recursive
>      inclusion is encountered.
> 
>  (7) Provide a script to go through and rejig the #includes of each source file
>      to have just the ones that are actually required.
> 
>  (8) Provide a make target that tests all the KAPI and UAPI headers by simply
>      passing them one at a time to the compiler and attempting to compile them.

By the way, I haven't commented on this in detail, but I like the concept.

	-hpa
