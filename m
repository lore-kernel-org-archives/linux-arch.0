From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Tue, 9 Jan 2018 16:23:48 -0600
Message-ID: <20180109222348.twmw62qwfhefqpoe@treble>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180109214149.yo3tnjesezgz63x4@treble>
 <CAPcyv4iUOWivipi1vjwm691dANBFq+H5Ztgtt-dzDjchbaDT-g@mail.gmail.com>
 <20180109214902.2d4ptkld2bof3js7@treble>
 <CAPcyv4iit=mESt2Mh0Wbvag3=tV6vEZt=NsHPUnj3ksgRzQKiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755966AbeAIWXw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jan 2018 17:23:52 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4iit=mESt2Mh0Wbvag3=tV6vEZt=NsHPUnj3ksgRzQKiQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>

On Tue, Jan 09, 2018 at 01:59:04PM -0800, Dan Williams wrote:
> > Right, but what's the purpose of preventing speculation past
> > access_ok()?
> 
> Caution. It's the same rationale for the nospec_array_ptr() patches.
> If we, kernel community, can identify any possible speculation past a
> bounds check we should inject a speculation mitigation. Unless there's
> a way to be 100% certain that the first unwanted speculation can be
> turned into a gadget later on in the instruction stream, err on the
> side of shutting it down early.

I'm all for being cautious.  The nospec_array_ptr() patches are fine,
and they make sense in light of the variant 1 CVE.

But that still doesn't answer my question.  I haven't seen *any*
rationale for this patch.  It would be helpful to at least describe
what's being protected against, even if it's hypothetical.  How can we
review it if the commit log doesn't describe its purpose?

-- 
Josh
