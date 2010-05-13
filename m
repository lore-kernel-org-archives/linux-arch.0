From: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC][PATCH 0/12] KVM, x86, ppc, asm-generic: moving dirty bitmaps
 to user space
Date: Thu, 13 May 2010 14:47:28 +0300
Message-ID: <4BEBE6D0.8020000@redhat.com>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com> <4BE7F6D7.3060005@redhat.com> <4BE7FB7B.5010600@oss.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BE7FB7B.5010600@oss.ntt.co.jp>
Sender: kvm-owner@vger.kernel.org
To: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Cc: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>, mtosatti@redhat.com, agraf@suse.de, fernando@oss.ntt.co.jp, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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

