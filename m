From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v8 02/28] x86/boot: Relocate definition of the initial
 state of CR0
Date: Sat, 02 Sep 2017 10:35:31 -0700
Message-ID: <1504373731.19040.4.camel@ranerica-desktop>
References: <20170819002809.111312-1-ricardo.neri-calderon@linux.intel.com>
         <20170819002809.111312-3-ricardo.neri-calderon@linux.intel.com>
         <20170825174133.r5xhcv5utfipsujo@pd.tnic>
         <1504152258.51857.8.camel@ranerica-desktop>
         <20170831095113.huidayjchfsdabjz@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21177 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbdIBRfc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 2 Sep 2017 13:35:32 -0400
In-Reply-To: <20170831095113.huidayjchfsdabjz@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Huang Rui <ray.huang@amd.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Vlastimil Babka <vbabka@suse.cz>, Chen Yucong <slaoub@gmail.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vge

On Thu, 2017-08-31 at 11:51 +0200, Borislav Petkov wrote:
> On Wed, Aug 30, 2017 at 09:04:18PM -0700, Ricardo Neri wrote:
> > Thank you! Is it necessary for me to submit a v9 with these updates?
> > Perhaps I can make these updates in branch for the maintainers to pull
> > when/if this series is ack'ed.
> 
> Don't do anything and let me go through the rest of them first. It is
> too late for this merge window anyway so we can take our time. Once you
> receive full feedback from me (and hopefully others) you can send what
> looks like to be a final v9 with all feedback incorporated. :-)

Sure, I will wait until you (and hopefully others) are done reviewing.

Thanks and BR,
Ricardo
