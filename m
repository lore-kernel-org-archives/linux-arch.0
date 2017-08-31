From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v8 02/28] x86/boot: Relocate definition of the initial
 state of CR0
Date: Thu, 31 Aug 2017 11:51:14 +0200
Message-ID: <20170831095113.huidayjchfsdabjz@pd.tnic>
References: <20170819002809.111312-1-ricardo.neri-calderon@linux.intel.com>
 <20170819002809.111312-3-ricardo.neri-calderon@linux.intel.com>
 <20170825174133.r5xhcv5utfipsujo@pd.tnic>
 <1504152258.51857.8.camel@ranerica-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1504152258.51857.8.camel@ranerica-desktop>
Sender: owner-linux-mm@kvack.org
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Huang Rui <ray.huang@amd.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Vlastimil Babka <vbabka@suse.cz>, Chen Yucong <slaoub@gmail.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>, Denys Vlasenko <dvla>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 30, 2017 at 09:04:18PM -0700, Ricardo Neri wrote:
> Thank you! Is it necessary for me to submit a v9 with these updates?
> Perhaps I can make these updates in branch for the maintainers to pull
> when/if this series is ack'ed.

Don't do anything and let me go through the rest of them first. It is
too late for this merge window anyway so we can take our time. Once you
receive full feedback from me (and hopefully others) you can send what
looks like to be a final v9 with all feedback incorporated. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
