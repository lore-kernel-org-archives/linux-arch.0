Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alln-iport-8.cisco.com ([173.37.142.95]:52186 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeJPC0H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2018 22:26:07 -0400
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <20181013104446.b3z26rwmiripqfks@gmail.com>
From: Enke Chen <enkechen@cisco.com>
Message-ID: <5bbe7c70-d6a8-7b37-51d4-eed9a99bc7e1@cisco.com>
Date: Mon, 15 Oct 2018 11:39:32 -0700
MIME-Version: 1.0
In-Reply-To: <20181013104446.b3z26rwmiripqfks@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: christian@brauner.io, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Enke Chen <enkechen@cisco.com>
Message-ID: <20181015183932.vTxOsA1RRGpq-mrl-ldFwmFCDtXN06Qpf8C-50ks6KE@z>

Hi, Christian:

As I replied to Jann, I will remove the code that does the setting on others
to make the code simpler and more secure.

Thanks.  -- Enke

>> +static bool set_predump_signal_perm(struct task_struct *p)
>> +{
>> +	const struct cred *cred = current_cred(), *pcred = __task_cred(p);
>> +
>> +	return uid_eq(pcred->uid, cred->euid) ||
>> +	       uid_eq(pcred->euid, cred->euid) ||
>> +	       capable(CAP_SYS_ADMIN);
> 
> So before proceeding I'd like to discuss at least two points:
> - how does this interact with the dumpability of a process?
> - do we need the capable(CAP_SYS_ADMIN) restriction to init_user_ns?
>   Seems we could make this work per-user-ns just like
>   PRCTL_SET_PDEATHSIG does?
> 
>> +}
