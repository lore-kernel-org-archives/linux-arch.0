Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933475Ab0EDQJE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 May 2010 12:09:04 -0400
Message-ID: <4BE04677.4060608@redhat.com>
Date: Tue, 04 May 2010 19:08:23 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
 offset macro
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com> <20100504220500.7695cd66.takuya.yoshikawa@gmail.com> <201005041703.00549.arnd@arndb.de>
In-Reply-To: <201005041703.00549.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>, mtosatti@redhat.com, agraf@suse.de, yoshikawa.takuya@oss.ntt.co.jp, fernando@oss.ntt.co.jp, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20100504160823.7H4UXZcZ3-cpV_J9LpkRxokzHXrbSfa9pd_pCh0PI5w@z>

On 05/04/2010 06:03 PM, Arnd Bergmann wrote:
> On Tuesday 04 May 2010, Takuya Yoshikawa wrote:
>    
>> Although we can use *_le_bit() helpers to treat bitmaps le arranged,
>> having le bit offset calculation as a seperate macro gives us more freedom.
>>
>> For example, KVM has le arranged dirty bitmaps for VGA, live-migration
>> and they are used in user space too. To avoid bitmap copies between kernel
>> and user space, we want to update the bitmaps in user space directly.
>> To achive this, le bit offset with *_user() functions help us a lot.
>>
>> So let us use the le bit offset calculation part by defining it as a new
>> macro: generic_le_bit_offset() .
>>      
> Does this work correctly if your user space is 32 bits (i.e. unsigned long
> is different size in user space and kernel) in both big- and little-endian
> systems?
>
> I'm not sure about all the details, but I think you cannot in general share
> bitmaps between user space and kernel because of this.
>    

That's why the bitmaps are defined as little endian u64 aligned, even on 
big endian 32-bit systems.  Little endian bitmaps are wordsize agnostic, 
and u64 alignment ensures we can use long-sized bitops on mixed size 
systems.

-- 
error compiling committee.c: too many arguments to function

