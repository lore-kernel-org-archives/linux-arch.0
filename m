Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60249 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933702AbeFGPvE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 11:51:04 -0400
Message-ID: <1528386472.4636.1.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 2/5] x86/fpu/xstate: Change some names to separate
 XSAVES system and user states
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 07 Jun 2018 08:47:52 -0700
In-Reply-To: <CALCETrXAx4vBUxf3VaePNm3HHLZkdTFAR9TV0T+A-jb2QL7Uag@mail.gmail.com>
References: <20180607143544.3477-1-yu-cheng.yu@intel.com>
         <20180607143544.3477-3-yu-cheng.yu@intel.com>
         <CALCETrXAx4vBUxf3VaePNm3HHLZkdTFAR9TV0T+A-jb2QL7Uag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607154752.LGmO1JOwN3OphQoaWpHRKdzfGdoHexWBpbwS-zTqr9g@z>

On Thu, 2018-06-07 at 08:38 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > To support XSAVES system states, change some names to distinguish
> > user and system states.
> >
> > Change:
> >   supervisor to system
> >   copy_init_fpstate_to_fpregs() to copy_init_fpstate_user_settings_to_fpregs()
> >   xfeatures_mask to xfeatures_mask_user
> >   XCNTXT_MASK to SUPPORTED_XFEATURES_MASK (states supported)
> 
> How about copy_init_user_fpstate_to_fpregs()?  It's shorter and more
> to the point.
> 
> --Andy

I will change that.

Yu-cheng
