Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbeJATmj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Oct 2018 15:42:39 -0400
Subject: Re: [REVIEW][PATCH 04/20] signal/x86: Use send_sig_mceerr as
 apropriate
References: <87y3bzk6yv.fsf@xmission.com>
 <20180918000546.12552-4-ebiederm@xmission.com>
 <alpine.DEB.2.21.1809182220310.1468@nanos.tec.linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <938579fd-e366-8aaf-add9-5a44e3e7892a@redhat.com>
Date: Mon, 1 Oct 2018 15:04:47 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809182220310.1468@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, kvm@vger.kernel.org
Message-ID: <20181001130447.7VB6_vyPjD35I0UwsrPJYSDc9uF9YY7_DcRFd4Nbjv0@z>

On 18/09/2018 22:21, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
> 
> CC+ kvm folks
> 
>> This simplifies the code making it clearer what is going on.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
>> ---
>>  arch/x86/kvm/mmu.c | 11 +----------
>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
>> index a282321329b5..95349bfe3b59 100644
>> --- a/arch/x86/kvm/mmu.c
>> +++ b/arch/x86/kvm/mmu.c
>> @@ -3114,16 +3114,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
>>  
>>  static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *tsk)
>>  {
>> -	siginfo_t info;
>> -
>> -	clear_siginfo(&info);
>> -	info.si_signo	= SIGBUS;
>> -	info.si_errno	= 0;
>> -	info.si_code	= BUS_MCEERR_AR;
>> -	info.si_addr	= (void __user *)address;
>> -	info.si_addr_lsb = PAGE_SHIFT;
>> -
>> -	send_sig_info(SIGBUS, &info, tsk);
>> +	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
>>  }
>>  
>>  static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>> -- 
>> 2.17.1
>>
>>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
