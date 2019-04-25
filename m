Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46806 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfDYPf4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Apr 2019 11:35:56 -0400
Date: Thu, 25 Apr 2019 16:35:48 +0100
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH v6 22/26] x86/cet/shstk: ELF header parsing of Shadow
 Stack
Message-ID: <20190425153547.GG3567@e103592.cambridge.arm.com>
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
 <20181119214809.6086-23-yu-cheng.yu@intel.com>
 <20190425110211.GZ3567@e103592.cambridge.arm.com>
 <e7bbb51291434a9c8526d7b617929465d5784121.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7bbb51291434a9c8526d7b617929465d5784121.camel@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20190425153548.rZMpEWzmE5Z570jlRTnUkmbdqKKqDbfoJXCS6u7wj80@z>

On Thu, Apr 25, 2019 at 08:14:52AM -0700, Yu-cheng Yu wrote:
> On Thu, 2019-04-25 at 12:02 +0100, Dave Martin wrote:
> > On Mon, Nov 19, 2018 at 01:48:05PM -0800, Yu-cheng Yu wrote:
> > > Look in .note.gnu.property of an ELF file and check if Shadow Stack needs
> > > to be enabled for the task.
> > 
> > What's the status of this series?  I don't see anything in linux-next
> > yet.
> > 
> > For describing ELF features, Arm has recently adopted
> > NT_GNU_PROPERTY_TYPE_0, with properties closely modelled on
> > GNU_PROPERTY_X86_FEATURE_1_AND etc. [1]
> > 
> > So, arm64 will be need something like this patch for supporting new
> > features (such as the Branch Target Identification feature of ARMv8.5-A
> > [2]).
> > 
> > If this series isn't likely to merge soon, can we split this patch into
> > generic and x86-specific parts and handle them separately?
> > 
> > It would be good to see the generic ELF note parsing move to common
> > code -- I'll take a look and comment in more detail.
> 
> Yes, I will work on that.

Thanks.  I may try to hack something in the meantime based on your
patch.

One other question: according to the draft spec at
https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI, it
looks like the .note.gnu.property section is supposed to be marked with
SHF_ALLOC in object files.

I think that means that the linker will map it with a PT_LOAD entry in
the program header table in addition to the PT_NOTE that describes the
location of the note.  I need to check what the toolchain actually
does.

If so, can we simply rely on the notes being already mapped, rather than
needing to do additional I/O on the ELF file to fetch the notes?

[...]

Cheers
---Dave
