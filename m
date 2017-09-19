Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:40384
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751237AbdISNua (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Sep 2017 09:50:30 -0400
Subject: Re: [Part1 PATCH v4 15/17] percpu: introduce
 DEFINE_PER_CPU_UNENCRYPTED
References: <20170916123418.37807-1-brijesh.singh@amd.com>
 <20170916123418.37807-16-brijesh.singh@amd.com>
 <20170919103906.GM4733@nazgul.tnic>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c17b7ac8-961b-8e3f-902f-40b18b80c993@amd.com>
Date: Tue, 19 Sep 2017 08:50:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170919103906.GM4733@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@suse.de>
Cc: brijesh.singh@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org
Message-ID: <20170919135020.USUf5MH7TYAuAtWuRtjJENkd9Uv4NYdAN-2BrfculkE@z>

Hi Boris,

On 09/19/2017 05:39 AM, Borislav Petkov wrote:
...

>> @@ -815,6 +825,7 @@
>>   	. = ALIGN(cacheline);						\
>>   	*(.data..percpu)						\
>>   	*(.data..percpu..shared_aligned)				\
>> +	PERCPU_UNENCRYPTED_SECTION					\
>>   	VMLINUX_SYMBOL(__per_cpu_end) = .;
> 
> So looking at this more: I'm wondering if we can simply reuse the
> PER_CPU_SHARED_ALIGNED_SECTION definition which is for shared per-CPU
> sections. Instead of introducing a special section which is going to be
> used only by SEV, practically.
> 
> Because "shared" also kinda implies that it is shared by multiple agents
> and those agents can just as well be guest and hypervisor. And then that
> patch is gone too.
> 
> Hmmm...?
> 

"..shared_aligned" section does not start and end with page-size alignment.
Since the C-bit works on PAGE_SIZE alignment hence the "..unencrypted" section
starts and ends with page-size alignment. The closest I can find is
"..page_aligned" but again it does not end with page-size alignment.

Additionally, since we clear the C-bit from unencrypted section hence we
should avoid overloading the existing section -- we don't want to expose more
than we wish.
