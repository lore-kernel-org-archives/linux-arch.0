From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v9 02/29] x86/boot: Relocate definition of the initial
 state of CR0
Date: Fri, 27 Oct 2017 12:02:19 -0700
Message-ID: <20171027190219.GA7057@voyager>
References: <1507089272-32733-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1507089272-32733-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <CALCETrUced9TVsMQ=cjFfDuDfLQsZWu0GOoRCmHn4PsSwrfOdw@mail.gmail.com>
 <20171026090045.GA6438@nazgul.tnic>
 <CALCETrXw2r-HD+9SwT0ndRVX2YR-_g6BKEfDd6i0ci5q_Z4S4Q@mail.gmail.com>
 <20171026125513.GB12068@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51188 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbdJ0TD3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Oct 2017 15:03:29 -0400
Content-Disposition: inline
In-Reply-To: <20171026125513.GB12068@nazgul.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Huang Rui <ray.huang@amd.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Vlastimil Babka <vbabka@suse.cz>, Chen Yucong <slaoub@gmail.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vg

On Thu, Oct 26, 2017 at 02:55:13PM +0200, Borislav Petkov wrote:
> On Thu, Oct 26, 2017 at 02:02:02AM -0700, Andy Lutomirski wrote:
> > I'm assuming that UMIP_REPORTED_CR0 will never change.  If CR0 gets a
> > new field that we set some day, then I assume that CR0_STATE would add
> > that bit but UMIP_REPORTED_CR0 would not.
> 
> Yeah, let's do that when it is actually needed.

Thanks Andy! I reasoned that for UMIP could report CR0_STATE a value that
is already revealed in the source code. Thus, if CR0 ever changes at run
time, an attacker could only see what is set programmatically.

BR,

Ricardo
