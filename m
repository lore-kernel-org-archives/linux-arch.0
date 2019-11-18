Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37818 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVgJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2019 16:36:09 -0500
Date: Tue, 19 Nov 2019 00:36:03 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] ELF: warn if process starts with executable stack
Message-ID: <20191118213603.GA24086@avx2>
References: <20191118145114.GA9228@avx2>
 <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, security@kernel.org, ben.dooks@codethink.co.uk
Message-ID: <20191118213603.EFfKFoRaCl2yL69rjzimxhdvinjMZDBGLjgT4_aC-Uc@z>

On Mon, Nov 18, 2019 at 12:54:57PM -0800, Andrew Morton wrote:
> On Mon, 18 Nov 2019 17:51:15 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > PT_GNU_STACK is fail open design,
> 
> Not sure what this means.  Please expand on the motivation for this
> change.
> 
> > at least warn people that something
> > isn't right.
> 
> People who use an executable stack get a kernel splat.  How is that
> useful?

There were two stories about silent downgrade to an executable stack:

1)
compiling .S file and linking it to normal code:

	$ cat f.S
	.intel_syntax noprefix
	.text
	.globl f
	f:
	        ret

will silently add PT_GNU_STACK segment with RWE permissions

2)
closures with nested functions will require executable stack
https://nullprogram.com/blog/2019/11/15/

> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -762,6 +762,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
> >  		goto out_unlock;
> >  	BUG_ON(prev != vma);
> >  
> > +#ifdef CONFIG_MMU

This code is already under CONFIG_MMU. I'll resend.
