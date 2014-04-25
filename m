Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11490 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbaDYQyr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Apr 2014 12:54:47 -0400
Message-ID: <535A9356.8060608@intel.com>
Date: Fri, 25 Apr 2014 09:54:46 -0700
From: Dave Hansen <dave.hansen@intel.com>
MIME-Version: 1.0
Subject: Re: Dirty/Access bits vs. page content
References: <53558507.9050703@zytor.com> <CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com> <20140422075459.GD11182@twins.programming.kicks-ass.net> <CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com> <alpine.LSU.2.11.1404221847120.1759@eggly.anvils> <20140423184145.GH17824@quack.suse.cz> <CA+55aFwm9BT4ecXF7dD+OM0-+1Wz5vd4ts44hOkS8JdQ74SLZQ@mail.gmail.com> <20140424065133.GX26782@laptop.programming.kicks-ass.net> <alpine.LSU.2.11.1404241110160.2443@eggly.anvils> <CA+55aFwVgCshsVHNqr2EA1aFY18A2L17gNj0wtgHB39qLErTrg@mail.gmail.com> <alpine.LSU.2.11.1404241252520.3455@eggly.anvils> <CA+55aFyUyD_BASjhig9OPerYcMrUgYJUfRLA9JyB_x7anV1d7Q@mail.gmail.com> <1398389846.8437.6.camel@pasglop> <1398393700.8437.22.camel@pasglop> <CA+55aFyO+-GehPiOAPy7-N0ejFrsNupWHG+j5hAs=R=RuPQtDg@mail.gmail.com> <5359CD7C.5020604@zytor.com> <CA+55aFzktDDr5zNh-7gDhXW6-7_BP_MvKHEoLi9=td6XvwzaUA@mail.gmail.com> <alpine.LSU.2.11.1404250414590.5198@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1404250414590.5198@eggly.anvils>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hughd@google.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
Message-ID: <20140425165446.mGoY5-M0GsidQNMlBwAI_R25O5TR22AQPvLbKsxe-D4@z>

On 04/25/2014 05:01 AM, Hugh Dickins wrote:
> Er, i_mmap_mutex.
> 
> That's what unmap_mapping_range(), and page_mkclean()'s rmap_walk,
> take to iterate over the file vmas.  So perhaps there's no race at all
> in the unmap_mapping_range() case.  And easy (I imagine) to fix the
> race in Dave's racewrite.c use of MADV_DONTNEED: untested patch below.
> 
> But exit and munmap() don't take i_mmap_mutex: perhaps they should
> when encountering a VM_SHARED vma (I believe VM_SHARED should be
> peculiar to having vm_file set, but test both below because I don't
> want to oops in some odd corner where a special vma is set up).

Hey Hugh,

Do you want some testing on this?
