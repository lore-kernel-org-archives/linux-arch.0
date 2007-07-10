Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:58820 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760961AbXGJVIi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2007 17:08:38 -0400
Received: by nf-out-0910.google.com with SMTP id g13so99471nfb
        for <linux-arch@vger.kernel.org>; Tue, 10 Jul 2007 14:08:37 -0700 (PDT)
Message-ID: <ec870ced0707101408p25b6115ao20aa5835072e7bad@mail.gmail.com>
Date: Tue, 10 Jul 2007 23:08:33 +0200
From: "Pawel Dziepak" <hryssta@gmail.com>
Subject: Re: [x86 setup 13/33] Header file to produce 16-bit code with gcc
In-Reply-To: <4693EF8E.9070403@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11840359321823-git-send-email-hpa@zytor.com>
	 <11840373002601-git-send-email-hpa@zytor.com>
	 <108510B6-B9BE-49D4-BDCA-E25CA20CB29B@kernel.crashing.org>
	 <200707101721.58937.ak@suse.de> <4693AA56.9040109@zytor.com>
	 <551EA412-3D35-4BCD-ACAE-B6A7BE3CBF9B@kernel.crashing.org>
	 <4693EF8E.9070403@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On 7/10/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > The alternative, of course, is to compile to an .s file and insert
> > .code16gcc into the .s file.  This makes the Makefile uglier, but
> > would
> > be more resilient against oddball gcc changes.
>
> This would be even more fragile.  The exact format of GCC's
> assembler code output isn't defined at all, so in principle
> this is a hopeless task.  In practice just putting the
> .code16gcc directive on the first line would likely work
> though, GCC never generates a .code32 AFAIK, but it isn't
> guaranteed that this will work (or will keep working).

Unfortunately, .code16gcc is still experimental (at least binutils'
website says that). What is worse, it says that it is possible that
16bit code produced on GCC won't work on pre-80386 processors (before
switching to protected mode you have to think about cpu as a
pre-80386).

I don't think that -m16 flag will be introduced quickly. In fact, only
OS developers _sometimes_ use 16 bit code...

I did a fast test and now I know that assembler instructions are
almost ignored by GCC and passed to gas. The situation is the same
with .code16gcc, what mean that gas has to translate 32bit code from
GCC to 16 bit code. The result binary was correct 16 bit program (at
least its code looked good), but it is IMHO too many translations from
C to 32bit assembler and then to 16bit assembler, that can cause
unpredictable errors.

Additionally, I prefer to write architecture depend procedures in
assembler (but is only *my* opinion, and you probably disagree).
Assembler is faster, you have bigger control over the code, and
portability of C is in this circumstances not necessary.

Pawel
