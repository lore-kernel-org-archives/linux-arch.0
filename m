Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from seketeli.net ([94.23.218.202]:45850 "EHLO ms.seketeli.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755166AbcLNJg3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Dec 2016 04:36:29 -0500
From: Dodji Seketeli <dodji@seketeli.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
References: <20161201125545.406d092c@roar.ozlabs.ibm.com>
        <1480559754.16599.92.camel@decadent.org.uk>
        <20161201143928.07a08348@roar.ozlabs.ibm.com>
        <6e8cf20b-2d2f-ba1f-e02c-c757d5a25db7@suse.com>
        <20161209133308.0acbb57a@roar.ozlabs.ibm.com>
        <1481296893.4509.135.camel@hellion.org.uk>
        <20161210021529.4a6e684f@roar.ozlabs.ibm.com>
        <86vaus3eld.fsf@seketeli.org>
        <f7c5d50d-8930-7ab1-62bb-8a5d0aead988@suse.com>
        <867f72vqec.fsf@seketeli.org> <20161214091539.GA9000@sepie.suse.cz>
Date: Wed, 14 Dec 2016 10:36:25 +0100
In-Reply-To: <20161214091539.GA9000@sepie.suse.cz> (Michal Marek's message of
        "Wed, 14 Dec 2016 10:15:39 +0100")
Message-ID: <86twa6svhi.fsf@seketeli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ian Campbell <ijc@hellion.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20161214093625.rnmlwbL4KUYnPsx0yvaJArlOP5cR4foM5DsAM7ecJqs@z>

Michal Marek <mmarek@suse.com> a écrit:

[...]

> A minimal example would be
>
> t1.c:
> struct s1;
> struct s2 {
> 	int i;
> }
> struct s3 {
> 	struct s1 *ptr1;
> 	struct s2 *ptr2;
> }
> void foo(struct s3*);
> EXPORT_SYMBOL(foo);
>
> t2.c:
> struct s1 {
> 	int j;
> }
> struct s2;
> struct s3 {
> 	struct s1 *ptr1;
> 	struct s2 *ptr2;
> }
> void foo(struct s3*);
> EXPORT_SYMBOL(foo);
>
> genksyms expands this to
> void foo ( struct s3 { struct s1 { UNKNOWN } * ptr1 ; struct s2 { int i ; } * ptr2 ; } * )
>
> or
>
> void foo ( struct s3 { struct s1 { int j ; } * ptr1 ; struct s2 { UNKNOWN } * ptr2 ; } * )
> respectively.

Thanks, I have built an independant test case from this:

$ cat t1.c
struct s1;
struct s2 {
	int i;
};
struct s3 {
	struct s1 *ptr1;
	struct s2 *ptr2;
};
void foo(struct s3*);
$ cat t2.c
struct s1 {
	int j;
};
struct s2;
struct s3 {
	struct s1 *ptr1;
	struct s2 *ptr2;
};
void foo(struct s3*);
$ gcc -g -c t1.c
$ gcc -g -c t2.c
$ abidiff t1.o t2.o
$ 

So, as you see here, abidiff considers t1.o and t2.o has having the same
ABI, so it considers the two foo functions to be equivalent.

> The types are the same, but their visibility in the different
> compilation units differs.

I see, for genksyms, the order of declarations matters, especially when
forward declarations are involved.

Libabigail does a "whole binary" analysis of types.

So, consider the point of use of the type 'struct s1*'.  Even if 'struct
s' is just forward-declared at that point, the declaration of struct s1
is "resolved" to its definition.  Even if the definition comes later in
the binary.

In other words, if struct s1 is defined in the binary, you'll never have
that "struct s1 {UNKNOWN} *ptr1;" that you see in genksyms's
representation.

Cheers,

-- 
		Dodji
