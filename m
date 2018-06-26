Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38081 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751796AbeFZPA2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Jun 2018 11:00:28 -0400
Message-ID: <1530025017.27091.1.camel@intel.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Tue, 26 Jun 2018 07:56:57 -0700
In-Reply-To: <CALCETrWYx5nCtwGAqTZBWOB+aw+eEcnQhe6Sn1o+O356g7Km9A@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <CALCETrWYx5nCtwGAqTZBWOB+aw+eEcnQhe6Sn1o+O356g7Km9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Linux API <linux-api@vger.kernel.org>, Jann Horn <jannh@google.com>, Florian Weimer <fweimer@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180626145657.QVxYtJyH6VwMCrNzN7j3alsdRQFMmfB6Gm84OYfxOeg@z>

On Mon, 2018-06-25 at 22:26 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com>
> wrote:
> > 
> > 
> > This series introduces CET - Shadow stack
> I think you should add some mitigation against sigreturn-oriented
> programming.  How about creating some special token on the shadow
> stack that indicates the presence of a signal frame at a particular
> address when delivering a signal and verifying and popping that token
> in sigreturn?  The token could be literally the address of the signal
> frame, and you could make this unambiguous by failing sigreturn if
> CET
> is on and the signal frame is in executable memory.
> 
> IOW, it would be a shame if sigreturn() itself became a convenient
> CET-bypassing gadget.
> 
> --Andy

I will look into that.

Thanks,
Yu-cheng
