From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v9 02/29] x86/boot: Relocate definition of the initial
 state of CR0
Date: Thu, 26 Oct 2017 11:00:45 +0200
Message-ID: <20171026090045.GA6438@nazgul.tnic>
References: <1507089272-32733-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1507089272-32733-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <CALCETrUced9TVsMQ=cjFfDuDfLQsZWu0GOoRCmHn4PsSwrfOdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdJZJAv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Oct 2017 05:00:51 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrUced9TVsMQ=cjFfDuDfLQsZWu0GOoRCmHn4PsSwrfOdw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Liang Z Li <liang.z.li@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, Huang Rui <ray.huang@amd.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Vlastimil Babka <vbabka@suse.cz>, Chen Yucong <slaoub@gmail.com>, "Ravi V. Shankar" <ravi.v.shankar@intel>

On Thu, Oct 26, 2017 at 12:51:25AM -0700, Andy Lutomirski wrote:
> with the slight caveat that I think it might be a wee bit better if
> UMIP emulation used a separate define UMIP_REPORTED_CR0.

Why, do you see CR0_STATE and UMIP_REPORTED_CR0 becoming different at
some point?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
