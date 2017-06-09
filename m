From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] refcount: Create unchecked atomic_t implementation
Date: Fri, 9 Jun 2017 09:20:36 +0200
Message-ID: <20170609072036.GK8337@worktop.programming.kicks-ass.net>
References: <20170608025831.GA43608@beast>
 <20170608065809.GC14568@infradead.org>
 <2236FBA76BA1254E88B949DDB74E612B6FF0E5C7@IRSMSX102.ger.corp.intel.com>
 <20170608200931.GC2464@linux-80c1.suse>
 <cea7c45e-511a-38ce-6b70-9a3a80108414@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56732 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdFIHVL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 03:21:11 -0400
Content-Disposition: inline
In-Reply-To: <cea7c45e-511a-38ce-6b70-9a3a80108414@colorfullife.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, "Reshetova, Elena" <elena.reshetova@intel.com>, Christoph Hellwig <hch@infradead.org>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, "arozansk@redhat.com" <arozansk@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@>

On Fri, Jun 09, 2017 at 06:24:04AM +0200, Manfred Spraul wrote:
> Hi Davidlohr,
> 
> On 06/08/2017 10:09 PM, Davidlohr Bueso wrote:
> >
> >Yes, this would be a prerequisite for ipc; which I initially thought
> >didn't
> >take a performance hit.
> >
> Did you see a regression for ipc?

I'd be most interested in having a benchmark that shows a regression.
Please share.
