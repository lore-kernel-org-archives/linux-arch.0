From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] Break out types from <linux/list.h> to <linux/list_types.h>.
Date: Sat, 3 Jul 2010 21:47:58 -0400
Message-ID: <4C2FE84E.4010407@tilera.com>
References: <201007021811.04197.arnd@arndb.de> <4C2E3F1F.3010202@tilera.com> <20100702204817.GB5842@parisc-linux.org> <201007031100.43158.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([72.1.168.231]:21273 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756494Ab0GDBsD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 3 Jul 2010 21:48:03 -0400
In-Reply-To: <201007031100.43158.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 7/3/2010 5:00 AM, Arnd Bergmann wrote:
> On Friday 02 July 2010 22:48:17 Matthew Wilcox wrote:
>   
>> I wouldn't mind seeing kvm_types.h, rwlock_types.h and spinlock_types.h
>> merged into types.h, personally.  They're all pretty fundamental kernel
>> kind of types.  It's a matter of taste, and I'm not particularly fussed
>> one way or the other.
>>
>> mm_types.h is complex and full of mm-specific information, so keeping
>> it separate makes sense to me.
>>
>> I just object to the unnecessary creation of tiny files like this.
>> Which is how we ended up with atomic_t and atomic64_t in there in the
>> first place :-)
>>     
> Ah, I didn't notice you had moved the atomic types in there. I agree that
> the list types are in the same general category and it makes sense
> to treat them the same way.
>
> For rwlock_types.h and spinlock_types.h, I think including them in types.h
> would really cause too much other crap to be pulled in through lockdep
> and other things we might need in there in the future, which would in turn
> cause the same problems with types.h that Chris is trying to avoid
> in the first place by moving stuff out of list.h.
>   

Sounds like we have a consensus on moving the list_head, hlist_head, and
hlist_node types to <linux/types.h>.  I assume everyone is agreed that
initializers, etc., should stay in <linux/list.h>.  I will send out a
revised git patch on Sunday.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
