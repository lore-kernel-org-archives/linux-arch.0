Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36104 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964Ab0EMLrw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2010 07:47:52 -0400
Message-ID: <4BEBE6D0.8020000@redhat.com>
Date: Thu, 13 May 2010 14:47:28 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 0/12] KVM, x86, ppc, asm-generic: moving dirty bitmaps
 to user space
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com> <4BE7F6D7.3060005@redhat.com> <4BE7FB7B.5010600@oss.ntt.co.jp>
In-Reply-To: <4BE7FB7B.5010600@oss.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Cc: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>, mtosatti@redhat.com, agraf@suse.de, fernando@oss.ntt.co.jp, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20100513114728.onVLUFkoEd7takHsoGrh9rJCd-qj_bt3BgKxgShMipY@z>

On 05/10/2010 03:26 PM, Takuya Yoshikawa wrote:
>> No doubt get.org -> get.opt is measurable, but get.opt->switch.opt is
>> problematic. Have you tried profiling to see where the time is spent
>> (well I can guess, clearing the write access from the sptes).
>
>
> Sorry but no, and I agree with your guess.
> Anyway, I want to do some profiling to confirm this guess.
>
>
> BTW, If we only think about performance improvement of time, optimized
> get(get.opt) may be enough at this stage.
>
> But if we consider the future expansion like using user allocated 
> bitmaps,
> new API's introduced for switch.opt won't become waste, I think, 
> because we
> need a structure to get and export bitmap addresses.

User allocated bitmaps have the advantage of reducing pinned memory.  
However we have plenty more pinned memory allocated in memory slots, so 
by itself, user allocated bitmaps don't justify this change.

Perhaps if we optimize memory slot write protection (I have some ideas 
about this) we can make the performance improvement more pronounced.

-- 
error compiling committee.c: too many arguments to function

