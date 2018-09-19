Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:45795 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeIST2D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Sep 2018 15:28:03 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-3-ebiederm@xmission.com>
        <alpine.DEB.2.21.1809182217000.1468@nanos.tec.linutronix.de>
Date: Wed, 19 Sep 2018 15:49:50 +0200
In-Reply-To: <alpine.DEB.2.21.1809182217000.1468@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 18 Sep 2018 22:19:14 +0200
        (CEST)")
Message-ID: <87k1nhfvgh.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [REVIEW][PATCH 03/20] signal/x86: Move MCE error reporting out of force_sig_info_fault
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180919134950.Rbd4qQrF94eZc63NGjoOYd2ND4IfnspIBUZcnQH8CXk@z>

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
>>  #ifdef CONFIG_MEMORY_FAILURE
>>  	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
>> +		unsigned lsb = 0;
>
> Newline between variable declaration and code please.
>
>>  		printk(KERN_ERR
>>  	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
>>  			tsk->comm, tsk->pid, address);
>
> Can you please convert that to pr_err() while at it?
>
>> -		code = BUS_MCEERR_AR;
>> +		if (fault & VM_FAULT_HWPOISON_LARGE)
>> +			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
>> +		if (fault & VM_FAULT_HWPOISON)
>> +			lsb = PAGE_SHIFT;
>> +		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, tsk);
>> +		return;
>>  	}
>
> With that fixed:
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Fixes applied.

Eric
