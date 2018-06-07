From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 03/10] x86/cet: Signal handling for shadow stack
Date: Thu, 7 Jun 2018 13:17:20 -0700
Message-ID: <22ccde18-6175-fc57-d1a3-06140b419116@linux.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-4-yu-cheng.yu@intel.com>
 <CALCETrWo77RS_wOzskw5OG-LdC1S-b_NY=uPWUmPbQEnNwANgQ@mail.gmail.com>
 <1528402350.5265.21.camel@2b52.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528402350.5265.21.camel@2b52.sc.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, Andy Lutomirski <luto@amacapital.net>
Cc: Florian Weimer <fweimer@redhat.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On 06/07/2018 01:12 PM, Yu-cheng Yu wrote:
>>> +int cet_restore_signal(unsigned long ssp)
>>> +{
>>> +       if (!current->thread.cet.shstk_enabled)
>>> +               return 0;
>>> +       return cet_set_shstk_ptr(ssp);
>>> +}
>> This will blow up if the shadow stack enabled state changes in a
>> signal handler.  Maybe we don't care.
> Yes, the task will get a control protection fault.

Sounds like something to add to the very long list of things that are
unwise to do in a signal handler.  Great manpage fodder.
