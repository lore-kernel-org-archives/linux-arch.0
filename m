Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45]:6020 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263204AbUF3Xoe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Jun 2004 19:44:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16611.20590.297525.314297@cargo.ozlabs.ibm.com>
Date: Thu, 1 Jul 2004 09:44:46 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: compat_sys_adjtimex
In-Reply-To: <20040630135342.01eaea83.davem@redhat.com>
References: <40E30E8F.3000601@intel.com>
	<20040630135342.01eaea83.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Arun Sharma <arun.sharma@intel.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller writes:
> On Wed, 30 Jun 2004 12:03:43 -0700
> Arun Sharma <arun.sharma@intel.com> wrote:
> 
> > This system call seems to be duplicated in many architectures. Here's
> > a patch which moves it to kernel/compat.c
> > 
> > We didn't touch ppc64, because it seems to be different. We've tested
> > this on ia64 with LTP.
> 
> PPC64 just wants some kind of callback invoked right after the
> do_adjtimex() call, it should be possible to provide a "do-nothing"
> macro in linux/compat.h that ppc can override in asm/compat.h

That code we have in ppc64 is about 10 times too clever to be allowed
to live.  It was basically trying to avoid the overhead of the rwlock
back in the days when xtime was protected by an rwlock.  Now that we
have seqlocks we could (and should :) get rid of it.

Paul.
