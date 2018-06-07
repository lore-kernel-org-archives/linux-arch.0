Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:3591 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbeFGQ57 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 12:57:59 -0400
Subject: Re: [PATCH 7/9] x86/mm: Shadow stack page fault error checking
References: <20180607143705.3531-1-yu-cheng.yu@intel.com>
 <20180607143705.3531-8-yu-cheng.yu@intel.com>
 <CALCETrXA--XrVNvPM4-Cv6-E6OFd=TZ5Gw_MWePt7MtqCBBqRg@mail.gmail.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <5764865a-1dd2-ec5b-c67c-1ea322aea203@linux.intel.com>
Date: Thu, 7 Jun 2018 09:56:36 -0700
MIME-Version: 1.0
In-Reply-To: <CALCETrXA--XrVNvPM4-Cv6-E6OFd=TZ5Gw_MWePt7MtqCBBqRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607165636.jTx6grjmIN9Ble7_IoPk7tvSQE3wmrmwSoHyNAqZH1s@z>

On 06/07/2018 09:26 AM, Andy Lutomirski wrote:
>>
>> +       /*
>> +        * Verify X86_PF_SHSTK is within a shadow stack VMA.
>> +        * It is always an error if there is a shadow stack
>> +        * fault outside a shadow stack VMA.
>> +        */
>> +       if (error_code & X86_PF_SHSTK) {
>> +               if (!(vma->vm_flags & VM_SHSTK))
>> +                       return 1;
>> +               return 0;
>> +       }
>> +
> What, if anything, would go wrong without this change?  It seems like
> it might be purely an optimization.  If so, can you mention that in
> the comment?

This is a fine exercise.  I'm curious what it does, too.

But, I really like it being explicit in the end.  If we depend on
implicit behavior, I really worry that someone breaks it accidentally.
