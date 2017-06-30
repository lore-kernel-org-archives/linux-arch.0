Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:58916 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbdF3SVC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2017 14:21:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87efu22set.fsf@xmission.com>
        <20170630123906.8865-3-ebiederm@xmission.com>
        <20170630.124505.736865959393416284.davem@davemloft.net>
Date: Fri, 30 Jun 2017 13:13:40 -0500
In-Reply-To: <20170630.124505.736865959393416284.davem@davemloft.net> (David
        Miller's message of "Fri, 30 Jun 2017 12:45:05 -0400 (EDT)")
Message-ID: <8737ahwdgr.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 3/8] signal/sparc: Document a conflict with SI_USER with SIGFPE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, oleg@redhat.com, avagin@virtuozzo.com, tglx@linutronix.de, greg@kroah.com, avagin@openvz.org, serge@hallyn.com, xemul@virtuozzo.com, gorcunov@openvz.org, peterz@infradead.org, w@1wt.eu, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, containers@lists.linux-foundation.org, mtk.manpages@gmail.com, sparclinux@vger.kernel.org
Message-ID: <20170630181340.DFN2gPXKTrHezeVJAuWQawi1kaXwc08S1c5DJJbYC7w@z>

David Miller <davem@davemloft.net> writes:

> From: "Eric W. Biederman" <ebiederm@xmission.com>
> Date: Fri, 30 Jun 2017 07:39:01 -0500
>
>> diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
>> index 2d9b79ccaa50..6bc5c677e92f 100644
>> --- a/arch/sparc/include/uapi/asm/siginfo.h
>> +++ b/arch/sparc/include/uapi/asm/siginfo.h
>> @@ -17,6 +17,11 @@
>>  #define SI_NOINFO	32767		/* no information in siginfo_t */
>>  
>>  /*
>> + * SIGFPE si_codes
>> + */
>> +#define FPE_FIXME	(__SI_FAULT|0)	/* Broken dup of SI_USER */
>> +
>> +/*
>>   * SIGEMT si_codes
>>   */
>>  #define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
>
> It's one thing to say FIXME in a comment in a kernel local header or
> C file.
>
> It's quite another to put this into the name of a macro which has
> visibility in the global user compilation namespace.
>
> I don't think you should really do that.

Good point.

Sigh.   It almost fits because we did do something off in the uapi
exported to userspace and we don't have a header file definition for
that case.

Still.  At this point arch/sparc/include/asm/siginfo.h is
a better fit for that definition.

I will respin and fix that.

I wish I knew what would make a better default floating point si_code on
sparc.  Using 0 aka SI_USER is doesn't fit at all.  Sigh.

Unfortunately I don't know the architecture well enough to even guess
what is going on in do_fpe_common when when no bits in fsr are set.

Any suggests for a better fix than just documenting that linux does
something weird and ill advised here?

Eric
