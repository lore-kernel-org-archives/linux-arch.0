From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [REVIEW][PATCH 7/9] signal/poewrpc: Specialize _exception_pkey
 for handling pkey exceptions
Date: Fri, 21 Sep 2018 10:58:44 +0200
Message-ID: <b140e12e-e1fa-1878-16d0-531ffc821e6f@c-s.fr>
References: <878t3yitze.fsf@xmission.com>
 <20180918175850.4437-7-ebiederm@xmission.com>
 <20180921185429.4cda432e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180921185429.4cda432e@canb.auug.org.au>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org



Le 21/09/2018 à 10:54, Stephen Rothwell a écrit :
> Hi Eric,
> 
> On Tue, 18 Sep 2018 19:58:48 +0200 "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>>
>> Now that _exception no longer calls _exception_pkey it is no longer
>> necessary to handle any signal with any si_code.  All pkey exceptions
>> are SIGSEGV with paired with SEGV_PKUERR.  So just handle
>> that case and remove the now unnecessary parameters from _exception_pkey.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Looks fine to me (small query below).
> 
> Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

In the patch title, s/poewrpc/powerpc

> 
>>   	clear_siginfo(&info);
>> -	info.si_signo = signr;
>> -	info.si_code = code;
>> +	info.si_signo = SIGSEGV;
>> +	info.si_code = SEGV_PKUERR;
>>   	info.si_addr = (void __user *) addr;
>>   	info.si_pkey = key;
>>   
>> -	force_sig_info(signr, &info, current);
>> +	force_sig_info(info.si_signo, &info, current);
>                         ^^^^^^^^^^^^^
> Why not just SIGSEGV?
> 
