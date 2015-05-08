Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60997 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbEHUPZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2015 16:15:25 -0400
Date: Fri, 8 May 2015 13:15:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] Allow user to request memory to be locked on page
 fault
Message-ID: <20150508131523.f970d13a213bca63bd6f2619@linux-foundation.org>
In-Reply-To: <20150508200610.GB29933@akamai.com>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
	<20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
	<20150508200610.GB29933@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@akamai.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150508201523.t0feFAcgdc5v45oeIFNje_jqsKndtonfB_LRo0mqOfE@z>

On Fri, 8 May 2015 16:06:10 -0400 Eric B Munson <emunson@akamai.com> wrote:

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

Why can't the application mmap only those parts of the file which it
wants and mlock those?

> I am working on getting startup times with and without this change for
> an application, I will post them as soon as I have them.

