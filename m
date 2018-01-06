From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed
 access_ok
Date: Sat, 6 Jan 2018 12:32:42 +0000
Message-ID: <20180106123242.77f4d860@alans-desktop>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:55054 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752895AbeAFMeP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Jan 2018 07:34:15 -0500
In-Reply-To: <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, 5 Jan 2018 18:52:07 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Jan 5, 2018 at 5:10 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > When access_ok fails we should always stop speculating.
> > Add the required barriers to the x86 access_ok macro.  
> 
> Honestly, this seems completely bogus.

Also for x86-64 if we are trusting that an AND with a constant won't get
speculated into something else surely we can just and the address with ~(1
<< 63) before copying from/to user space ? The user will then just
speculatively steal their own memory.

Alan
