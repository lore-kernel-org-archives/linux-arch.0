From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 7/9] x86/mm: Shadow stack page fault error checking
Date: Thu, 7 Jun 2018 09:56:36 -0700
Message-ID: <5764865a-1dd2-ec5b-c67c-1ea322aea203@linux.intel.com>
References: <20180607143705.3531-1-yu-cheng.yu@intel.com>
 <20180607143705.3531-8-yu-cheng.yu@intel.com>
 <CALCETrXA--XrVNvPM4-Cv6-E6OFd=TZ5Gw_MWePt7MtqCBBqRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrXA--XrVNvPM4-Cv6-E6OFd=TZ5Gw_MWePt7MtqCBBqRg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

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
