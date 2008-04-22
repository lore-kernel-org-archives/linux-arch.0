From: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Subject: Re: [patch 2/2]: introduce fast_gup
Date: Tue, 22 Apr 2008 10:07:47 +0200
Message-ID: <20080422080747.GA18587@elte.hu>
References: <20080328025455.GA8083@wotan.suse.de> <20080328030023.GC8083@wotan.suse.de> <1208444605.7115.2.camel@twins> <alpine.LFD.1.00.0804170814090.2879@woody.linux-foundation.org> <480C81C4.8030200@qumranet.com> <1208781013.7115.173.camel@twins> <480C9619.2050201@qumranet.com> <1208788547.7115.204.camel@twins> <20080422032319.GB21993@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080422032319.GB21993-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Clark Williams <williams-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>


* Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org> wrote:

> Linus's loop I will use for PAE. I'd love to know whether the hardware 
> walker actually does an atomic 64-bit load or not, though.

all x86 natural accesses (done by instructions) are MESI atomic as long 
as they lie on a natural word boundary. (which they do in the PTE case)

while the hardware walker is not an instruction, it would be highly 
unusal (and i'd claim, inherently broken) for the hardware walker to 
fetch a 64-bit pte value via two 32-bit accesses from two different 
versions of the same cacheline.

	Ingo
