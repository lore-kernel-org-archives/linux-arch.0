Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53726 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934118AbbEMN6J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 May 2015 09:58:09 -0400
Date: Wed, 13 May 2015 15:58:05 +0200
From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH 0/3] Allow user to request memory to be locked on page
 fault
Message-ID: <20150513135805.GA17708@dhcp22.suse.cz>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
 <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
 <20150508200610.GB29933@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150508200610.GB29933@akamai.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuahkh@osg.samsung.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150513135805.oeyN4EO7vSJn47bDH0FMSSA9SwqZSnPw3QfFkl0EOyU@z>

On Fri 08-05-15 16:06:10, Eric B Munson wrote:
> On Fri, 08 May 2015, Andrew Morton wrote:
> 
> > On Fri,  8 May 2015 15:33:43 -0400 Eric B Munson <emunson@akamai.com> wrote:
> > 
> > > mlock() allows a user to control page out of program memory, but this
> > > comes at the cost of faulting in the entire mapping when it is
> > > allocated.  For large mappings where the entire area is not necessary
> > > this is not ideal.
> > > 
> > > This series introduces new flags for mmap() and mlockall() that allow a
> > > user to specify that the covered are should not be paged out, but only
> > > after the memory has been used the first time.
> > 
> > Please tell us much much more about the value of these changes: the use
> > cases, the behavioural improvements and performance results which the
> > patchset brings to those use cases, etc.
> > 
> 
> The primary use case is for mmaping large files read only.  The process
> knows that some of the data is necessary, but it is unlikely that the
> entire file will be needed.  The developer only wants to pay the cost to
> read the data in once.  Unfortunately developer must choose between
> allowing the kernel to page in the memory as needed and guaranteeing
> that the data will only be read from disk once.  The first option runs
> the risk of having the memory reclaimed if the system is under memory
> pressure, the second forces the memory usage and startup delay when
> faulting in the entire file.

Is there any reason you cannot do this from the userspace? Start by
mmap(PROT_NONE) and do mmap(MAP_FIXED|MAP_LOCKED|MAP_READ|other_flags_you_need)
from the SIGSEGV handler?
You can generate a lot of vmas that way but you can mitigate that to a
certain level by mapping larger than PAGE_SIZE chunks in the fault
handler. Would that work in your usecase?
-- 
Michal Hocko
SUSE Labs
