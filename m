Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbeJPCa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Oct 2018 22:30:28 -0400
Date: Mon, 15 Oct 2018 20:43:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Message-ID: <20181015184358.GA12153@kroah.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <20181013064023.GA28177@kroah.com>
 <37401cea-5a37-2cd9-8595-8b07dfc4de7d@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37401cea-5a37-2cd9-8595-8b07dfc4de7d@cisco.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Message-ID: <20181015184358.5_xhX6xjYeEhtHxBuGedbF2mEtuvGt_z2EOfdfrT1hc@z>

On Mon, Oct 15, 2018 at 11:16:36AM -0700, Enke Chen wrote:
> Hi, Greg:
> 
> > Shouldn't there also be a manpage update, and a kselftest added for this
> > new user/kernel api that is being created?
> > 
> 
> I will submit a patch for manpage update once the code is accepted.

Writing a manpage update is key to see if what you are describing
actually matches the code you have submitted.  You should do both at the
same time so that they can be reviewed together.

> Regarding the kselftest, I am not sure.  Once the prctl() is limited to
> self (which I will do), the logic would be pretty straightforward. Not
> sure if the selftest would add much value.

If you do not have a test for this feature, how do you know it even
works at all?  How will you know if it breaks in a future kernel
release?  Have you tested this?  If so, how?

thanks,

greg k-h
