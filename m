Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34055 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033239AbdAEUL4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2017 15:11:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so107780wmi.1
        for <linux-arch@vger.kernel.org>; Thu, 05 Jan 2017 12:11:55 -0800 (PST)
Date: Thu, 5 Jan 2017 23:11:53 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
Message-ID: <20170105201153.GA27928@node.shutemov.name>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <20161227015413.187403-30-kirill.shutemov@linux.intel.com>
 <5a3dcc25-b264-37c7-c090-09981b23940d@intel.com>
 <20170105192910.q26ozg4ci4i3j2ai@black.fi.intel.com>
 <161ece66-fbf4-cb89-3da6-91b4851af69f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161ece66-fbf4-cb89-3da6-91b4851af69f@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20170105201153.4EucoltxyIkMgrrajfdIin2B67HduNUN_yOheUgR2x4@z>

On Thu, Jan 05, 2017 at 11:39:16AM -0800, Dave Hansen wrote:
> On 01/05/2017 11:29 AM, Kirill A. Shutemov wrote:
> > On Thu, Jan 05, 2017 at 11:13:57AM -0800, Dave Hansen wrote:
> >> On 12/26/2016 05:54 PM, Kirill A. Shutemov wrote:
> >>> MM would use min(RLIMIT_VADDR, TASK_SIZE) as upper limit of virtual
> >>> address available to map by userspace.
> >>
> >> What happens to existing mappings above the limit when this upper limit
> >> is dropped?
> > 
> > Nothing: we only prevent creating new mappings. All existing are not
> > affected.
> > 
> > The semantics here the same as with other resource limits.
> > 
> >> Similarly, why do we do with an application running with something
> >> incompatible with the larger address space that tries to raise the
> >> limit?  Say, legacy MPX.
> > 
> > It has to know what it does. Yes, it can change limit to the point where
> > application is unusable. But you can to the same with other limits.
> 
> I'm not sure I'm comfortable with this.  Do other rlimit changes cause
> silent data corruption?  I'm pretty sure doing this to MPX would.

Maybe it's too ugly, but MPX can set rlim_max to rlim_cur on enabling.

-- 
 Kirill A. Shutemov
