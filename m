From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -resend 01/27] linkage: new macros for assembler symbols
Date: Mon, 14 May 2018 10:03:05 +0200
Message-ID: <20180514080305.GA6607@gmail.com>
References: <20180510080644.19752-1-jslaby@suse.cz>
 <20180510080644.19752-2-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180510080644.19752-2-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, hpa@zytor.com, jpoimboe@redhat.com, Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, xen-devel@lists.xenproject.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org


* Jiri Slaby <jslaby@suse.cz> wrote:

>  Documentation/asm-annotations.rst | 218 ++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/linkage.h    |  10 +-
>  include/linux/linkage.h           | 257 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 475 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/asm-annotations.rst

Could you please split the documentation patch from the header file changes?

Thanks,

	Ingo
