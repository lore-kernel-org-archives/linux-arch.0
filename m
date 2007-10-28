Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:23516 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbXJ1IE2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Oct 2007 04:04:28 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1244395rvb
        for <linux-arch@vger.kernel.org>; Sun, 28 Oct 2007 01:04:27 -0700 (PDT)
Message-ID: <8bd0f97a0710280104k4784c7afo11b9d803e963ed13@mail.gmail.com>
Date: Sun, 28 Oct 2007 03:04:27 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: struct user . u_ar0
In-Reply-To: <4723DDDD.8050900@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4723DDDD.8050900@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On 10/27/07, H. Peter Anvin <hpa@zytor.com> wrote:
> I recently noticed that all architectures appear to have an entry n
> struct user called u_ar0:
>
>    struct user_pt_regs * u_ar0;  /* Used by gdb to help find the values
> for */
>                                  /* the registers. */
>
> In all cases, u_ar0 is a pointer type, although the type of pointer
> varies with the architecture.
>
> However, under no conditions does this field ever contain a pointer
> value!  It is set by the a.out code and its derivatives as an offset,
> not a pointer value (there are a total of four references in the kernel,
> in arch/{m68k,blackfin}/kernel/process.c, arch/x86/ia32/ia32_aout.c and
> fs/binfmt_aout.c -- they are all functionally identical and write-only):
>
> dump.u_ar0 = (void *)(((unsigned long)(&dump.regs)) - ((unsigned
> long)(&dump)));
>
> Any reason to *NOT* change this field to "unsigned long"?  <asm/user.h>,
> where struct user is defined, is not exported to userspace in any
> architecture as far as I can tell, although <linux/user.h>, which just
> contains #include <asm/user.h>, *is* exported (clearly a bug.)

Blackfin doesnt support a.out, so it may be easier to just change it
to "reserved2" (assuming this structure is part of our ABI), or delete
it (assuming the structure is internal to the kernel only).
-mike
