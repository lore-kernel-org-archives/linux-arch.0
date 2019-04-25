Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:53584 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfDYQU4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Apr 2019 12:20:56 -0400
Message-ID: <61ca9af34259921452aaeea047016c598ef73c77.camel@intel.com>
Subject: Re: [RFC PATCH v6 22/26] x86/cet/shstk: ELF header parsing of
 Shadow Stack
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 25 Apr 2019 09:20:44 -0700
In-Reply-To: <20190425153547.GG3567@e103592.cambridge.arm.com>
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
         <20181119214809.6086-23-yu-cheng.yu@intel.com>
         <20190425110211.GZ3567@e103592.cambridge.arm.com>
         <e7bbb51291434a9c8526d7b617929465d5784121.camel@intel.com>
         <20190425153547.GG3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20190425162044.2C-WcD5r5-1iL9OmQgKIeYA1cPX_SXh9tOT1aPFkJJc@z>

On Thu, 2019-04-25 at 16:35 +0100, Dave Martin wrote:
> On Thu, Apr 25, 2019 at 08:14:52AM -0700, Yu-cheng Yu wrote:
> > On Thu, 2019-04-25 at 12:02 +0100, Dave Martin wrote:
> > > [...]
> One other question: according to the draft spec at
> https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI, it
> looks like the .note.gnu.property section is supposed to be marked with
> SHF_ALLOC in object files.
> 
> I think that means that the linker will map it with a PT_LOAD entry in
> the program header table in addition to the PT_NOTE that describes the
> location of the note.  I need to check what the toolchain actually
> does.
> 
> If so, can we simply rely on the notes being already mapped, rather than
> needing to do additional I/O on the ELF file to fetch the notes?

Assuming that is mapped and we do copy_from_user, it will trigger page faults. 
I suspect in this case reading from the file is better?

Yu-cheng
