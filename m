Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38790 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935513AbeFNBHg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2018 21:07:36 -0400
Message-ID: <814fc15e80908d8630ff665be690ccbe6e69be88.camel@gmail.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 14 Jun 2018 11:07:23 +1000
In-Reply-To: <1528815820.8271.16.camel@2b52.sc.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
         <1528815820.8271.16.camel@2b52.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <20180614010723.N84UCInOe3k3CW7N7b4iIxQU0ZeJ-j7NUxZzynsyo1k@z>

On Tue, 2018-06-12 at 08:03 -0700, Yu-cheng Yu wrote:
> On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> > 
> > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > This series introduces CET - Shadow stack
> > > 
> > > At the high level, shadow stack is:
> > > 
> > > 	Allocated from a task's address space with vm_flags VM_SHSTK;
> > > 	Its PTEs must be read-only and dirty;
> > > 	Fixed sized, but the default size can be changed by sys admin.
> > > 
> > > For a forked child, the shadow stack is duplicated when the next
> > > shadow stack access takes place.
> > > 
> > > For a pthread child, a new shadow stack is allocated.
> > > 
> > > The signal handler uses the same shadow stack as the main program.
> > > 
> > 
> > Even with sigaltstack()?
> > 
> Yes.

I am not convinced that it would work, as we switch stacks, oveflow might
be an issue. I also forgot to bring up setcontext(2), I presume those
will get new shadow stacks

Balbir Singh.
