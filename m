From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 02/29] x86/boot: Relocate definition of the initial
 state of CR0
Date: Thu, 26 Oct 2017 00:51:25 -0700
Message-ID: <CALCETrUced9TVsMQ=cjFfDuDfLQsZWu0GOoRCmHn4PsSwrfOdw@mail.gmail.com>
References: <1507089272-32733-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1507089272-32733-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1507089272-32733-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Liang Z Li <liang.z.li@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, Huang Rui <ray.huang@amd.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Vlastimil Babka <vbabka@suse.cz>, Chen Yucong <slaoub@gmail.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Shuah Khan <shuah@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 3, 2017 at 8:54 PM, Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
> Both head_32.S and head_64.S utilize the same value to initialize the
> control register CR0. Also, other parts of the kernel might want to access
> this initial definition (e.g., emulation code for User-Mode Instruction
> Prevention uses this state to provide a sane dummy value for CR0 when
> emulating the smsw instruction). Thus, relocate this definition to a
> header file from which it can be conveniently accessed.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

with the slight caveat that I think it might be a wee bit better if
UMIP emulation used a separate define UMIP_REPORTED_CR0.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
