Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38328 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfCTLZ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Mar 2019 07:25:56 -0400
Date: Wed, 20 Mar 2019 11:25:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v12 00/13] arm64: untag user pointers passed to the kernel
Message-ID: <20190320112545.GB25040@arrakis.emea.arm.com>
References: <cover.1552929301.git.andreyknvl@google.com>
 <20190319113212.ca1d56301112454dfb5a39ba@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319113212.ca1d56301112454dfb5a39ba@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, khalid.aziz@oracle.com
Message-ID: <20190320112546.LcC8Mo8iV0KrZ7CaUNy7FkY08kJ6KQ-axD8MGKCEU1Q@z>

On Tue, Mar 19, 2019 at 11:32:12AM -0700, Andrew Morton wrote:
> On Mon, 18 Mar 2019 18:17:32 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
> > === Notes
> > 
> > This patchset is meant to be merged together with "arm64 relaxed ABI" [3].
> 
> What does this mean, precisely?  That neither series is useful without
> the other?  That either patchset will break things without the other?

This series does the work of relaxing the ABI w.r.t. pointer syscall
arguments for arm64 (while preserving backwards compatibility, we can't
break this). Vincenzo's patches [1] document the ABI relaxation and
introduce an AT_FLAG bit by which user space can check for the presence
of such support. So I'd say [1] goes on top of this series.

Once we agreed on the ABI definition, they should be posted as a single
series.

> Only a small fraction of these patches carry evidence of having been
> reviewed.  Fixable?

That's fixable, though the discussions go back to last summer mostly at
a higher level: are we sure these are the only places that need
patching? The outcome of such discussions was a document clarifying
which pointers user can tag and pass to the kernel based on the origins
of the memory range (e.g. anonymous mmap()).

I'd very much like to get input from the SPARC ADI guys on these series
(cc'ing Khalid). While currently for arm64 that's just a software
feature (the hardware one, MTE - memory tagging extensions, is coming
later), the ADI has similar requirements regarding the user ABI. AFAICT
from the SPARC example code, the user is not allowed to pass a tagged
pointers (non-zero top byte) into the kernel. Feedback from the Google
hwasan guys is that such approach is not practical for a generic
deployment of this feature (e.g. automatic tagging of heap allocations).

> Which maintainer tree would be appropriate for carrying these patches?

Given that the arm64 changes are fairly minimal, the -mm tree works for
me (once I reviewed/acked the patches and, ideally, get the SPARC people
onboard with such approach).

[1] https://lkml.org/lkml/2019/3/18/819

-- 
Catalin
