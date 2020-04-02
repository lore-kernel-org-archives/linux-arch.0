From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Date: Thu, 2 Apr 2020 19:03:28 +0200
Message-ID: <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:58988 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgDBRDc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Apr 2020 13:03:32 -0400
In-Reply-To: <20200402162942.GG23230@ZenIV.linux.org.uk>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, akpm@linux-foundation.org, keescook@chromium.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>



Le 02/04/2020 à 18:29, Al Viro a écrit :
> On Thu, Apr 02, 2020 at 07:34:16AM +0000, Christophe Leroy wrote:
>> Some architectures like powerpc64 have the capability to separate
>> read access and write access protection.
>> For get_user() and copy_from_user(), powerpc64 only open read access.
>> For put_user() and copy_to_user(), powerpc64 only open write access.
>> But when using unsafe_get_user() or unsafe_put_user(),
>> user_access_begin open both read and write.
>>
>> Other architectures like powerpc book3s 32 bits only allow write
>> access protection. And on this architecture protection is an heavy
>> operation as it requires locking/unlocking per segment of 256Mbytes.
>> On those architecture it is therefore desirable to do the unlocking
>> only for write access. (Note that book3s/32 ranges from very old
>> powermac from the 90's with powerpc 601 processor, till modern
>> ADSL boxes with PowerQuicc II modern processors for instance so it
>> is still worth considering)
>>
>> In order to avoid any risk based of hacking some variable parameters
>> passed to user_access_begin/end that would allow hacking and
>> leaving user access open or opening too much, it is preferable to
>> use dedicated static functions that can't be overridden.
>>
>> Add a user_read_access_begin and user_read_access_end to only open
>> read access.
>>
>> Add a user_write_access_begin and user_write_access_end to only open
>> write access.
>>
>> By default, when undefined, those new access helpers default on the
>> existing user_access_begin and user_access_end.
> 
> The only problem I have is that we'd better choose the calling
> conventions that work for other architectures as well.
> 
> AFAICS, aside of ppc and x86 we have (at least) this:
> arm:
> 	unsigned int __ua_flags = uaccess_save_and_enable();
> 	...
> 	uaccess_restore(__ua_flags);
> arm64:
> 	uaccess_enable_not_uao();
> 	...
> 	uaccess_disable_not_uao();
> riscv:
> 	__enable_user_access();
> 	...
> 	__disable_user_access();
> s390/mvc:
> 	old_fs = enable_sacf_uaccess();
> 	...
>          disable_sacf_uaccess(old_fs);
> 
> arm64 and riscv are easy - they map well on what we have now.
> The interesting ones are ppc, arm and s390.
> 
> You wants to specify the kind of access; OK, but...  it's not just read
> vs. write - there's read-write as well.  AFAICS, there are 3 users of
> that:
> 	* copy_in_user()
> 	* arch_futex_atomic_op_inuser()
> 	* futex_atomic_cmpxchg_inatomic()
> The former is of dubious utility (all users outside of arch are in
> the badly done compat code), but the other two are not going to go
> away.

user_access_begin() grants both read and write.

This patch adds user_read_access_begin() and user_write_access_begin() 
but it doesn't remove user_access_begin()

> 
> What should we do about that?  Do we prohibit such blocks outside
> of arch?
> 
> What should we do about arm and s390?  There we want a cookie passed
> from beginning of block to its end; should that be a return value?

That was the way I implemented it in January, see 
https://patchwork.ozlabs.org/patch/1227926/

There was some discussion around that and most noticeable was:

H. Peter (hpa) said about it: "I have *deep* concern with carrying state 
in a "key" variable: it's a direct attack vector for a crowbar attack, 
especially since it is by definition live inside a user access region."

> 
> And at least on arm that thing nests (see e.g. __clear_user_memset()
> there), so "stash that cookie in current->something" is not a solution...
> 
> Folks, let's sort that out while we still have few users of that
> interface; changing the calling conventions later will be much harder.
> Comments?
> 

This patch minimises the change by just adding user_read_access_begin() 
and user_write_access_begin() keeping the same parameters as the 
existing user_access_begin().

So I can come back to a mix of this patch and the January version if it 
corresponds to everyone's view, it will also be a bit easier for powerpc 
(especially book3s/32). But that didn't seem to be the expected 
direction back when we discussed it in January.

Christophe
