From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC][PATCH 3/3] math128, x86_64: Implement {mult,add}_u128 in
 64bit asm
Date: Wed, 25 Apr 2012 00:00:43 +0200
Message-ID: <1335304843.28150.246.camel@twins>
References: <20120424161039.293018424@chello.nl>
	   <20120424162224.588822231@chello.nl> <4F96D604.5050709@zytor.com>
	  <1335285395.28150.204.camel@twins> <4F96E01E.6040109@zytor.com>
	 <1335287973.28150.213.camel@twins> <4F96E0EB.7030904@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40853 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282Ab2DXWAy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2012 18:00:54 -0400
In-Reply-To: <4F96E0EB.7030904@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, 2012-04-24 at 10:20 -0700, H. Peter Anvin wrote:
> I have been told __int128 works for all versions of gcc which support
> x86-64, but I haven't verified it myself, no. 

The gcc version I have seems to grok it:

u128 mult_u64_u128(u64 a, u64 b)                                                             
{                                                                                            
        unsigned __int128 t = a;                                                             
        t *= b;                                                                              
        return U128_INIT(t >> 64, t);                                                        
}
#define mult_u64_u128 mult_u64_u128

generates:

        .p2align 4,,15
        .globl  mult_u64_u128
        .type   mult_u64_u128, @function
mult_u64_u128:
.LFB38:
        .cfi_startproc
        movq    %rsi, %rax
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        mulq    %rdi
        popq    %rbp
        .cfi_def_cfa_offset 8
        movq    %rax, %rdi
        movq    %rdx, %rax
        movq    %rdi, %rdx
        ret
        .cfi_endproc
.LFE38:
        .size   mult_u64_u128, .-mult_u64_u128

I haven't been able to make add_u128 generate sane code using __int128,
the conversion between my struct and the __int128 layout makes a horrid
mess.
