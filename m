From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Wed, 14 Dec 2016 10:44:07 +0100
Message-ID: <a3cd76cb-48ac-5d86-0a82-ac7b11738813@suse.com>
References: <20161201125545.406d092c@roar.ozlabs.ibm.com>
 <1480559754.16599.92.camel@decadent.org.uk>
 <20161201143928.07a08348@roar.ozlabs.ibm.com>
 <6e8cf20b-2d2f-ba1f-e02c-c757d5a25db7@suse.com>
 <20161209133308.0acbb57a@roar.ozlabs.ibm.com>
 <1481296893.4509.135.camel@hellion.org.uk>
 <20161210021529.4a6e684f@roar.ozlabs.ibm.com> <86vaus3eld.fsf@seketeli.org>
 <f7c5d50d-8930-7ab1-62bb-8a5d0aead988@suse.com> <867f72vqec.fsf@seketeli.org>
 <20161214091539.GA9000@sepie.suse.cz> <86twa6svhi.fsf@seketeli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46463 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755138AbcLNJoL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Dec 2016 04:44:11 -0500
In-Reply-To: <86twa6svhi.fsf@seketeli.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dodji Seketeli <dodji@seketeli.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ian Campbell <ijc@hellion.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2016-12-14 10:36, Dodji Seketeli wrote:
> Michal Marek <mmarek@suse.com> a écrit:
> 
> [...]
> 
>> A minimal example would be
>>
>> t1.c:
>> struct s1;
>> struct s2 {
>> 	int i;
>> }
>> struct s3 {
>> 	struct s1 *ptr1;
>> 	struct s2 *ptr2;
>> }
>> void foo(struct s3*);
>> EXPORT_SYMBOL(foo);
>>
>> t2.c:
>> struct s1 {
>> 	int j;
>> }
>> struct s2;
>> struct s3 {
>> 	struct s1 *ptr1;
>> 	struct s2 *ptr2;
>> }
>> void foo(struct s3*);
>> EXPORT_SYMBOL(foo);
>>
>> genksyms expands this to
>> void foo ( struct s3 { struct s1 { UNKNOWN } * ptr1 ; struct s2 { int i ; } * ptr2 ; } * )
>>
>> or
>>
>> void foo ( struct s3 { struct s1 { int j ; } * ptr1 ; struct s2 { UNKNOWN } * ptr2 ; } * )
>> respectively.
> 
> Thanks, I have built an independant test case from this:
> 
> $ cat t1.c
> struct s1;
> struct s2 {
> 	int i;
> };
> struct s3 {
> 	struct s1 *ptr1;
> 	struct s2 *ptr2;
> };
> void foo(struct s3*);
> $ cat t2.c
> struct s1 {
> 	int j;
> };
> struct s2;
> struct s3 {
> 	struct s1 *ptr1;
> 	struct s2 *ptr2;
> };
> void foo(struct s3*);
> $ gcc -g -c t1.c
> $ gcc -g -c t2.c
> $ abidiff t1.o t2.o
> $ 
> 
> So, as you see here, abidiff considers t1.o and t2.o has having the same
> ABI, so it considers the two foo functions to be equivalent.

Wow. That sounds too good to be true.


>> The types are the same, but their visibility in the different
>> compilation units differs.
> 
> I see, for genksyms, the order of declarations matters, especially when
> forward declarations are involved.
> 
> Libabigail does a "whole binary" analysis of types.
> 
> So, consider the point of use of the type 'struct s1*'.  Even if 'struct
> s' is just forward-declared at that point, the declaration of struct s1
> is "resolved" to its definition.  Even if the definition comes later in
> the binary.

But there isn't any definition of struct s1 in t1.o. Does abidiff
"steal" the definition from the other object file? That would be
legitimate, I'm just curious.

Thanks,
Michal
