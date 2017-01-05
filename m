Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20578 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756239AbdAETjR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Jan 2017 14:39:17 -0500
Subject: Re: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <20161227015413.187403-30-kirill.shutemov@linux.intel.com>
 <5a3dcc25-b264-37c7-c090-09981b23940d@intel.com>
 <20170105192910.q26ozg4ci4i3j2ai@black.fi.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <161ece66-fbf4-cb89-3da6-91b4851af69f@intel.com>
Date: Thu, 5 Jan 2017 11:39:16 -0800
MIME-Version: 1.0
In-Reply-To: <20170105192910.q26ozg4ci4i3j2ai@black.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20170105193916.onhMFEx_PR8VHPdAgxnK3UTXIGui44G6gtY255aGkNo@z>

On 01/05/2017 11:29 AM, Kirill A. Shutemov wrote:
> On Thu, Jan 05, 2017 at 11:13:57AM -0800, Dave Hansen wrote:
>> On 12/26/2016 05:54 PM, Kirill A. Shutemov wrote:
>>> MM would use min(RLIMIT_VADDR, TASK_SIZE) as upper limit of virtual
>>> address available to map by userspace.
>>
>> What happens to existing mappings above the limit when this upper limit
>> is dropped?
> 
> Nothing: we only prevent creating new mappings. All existing are not
> affected.
> 
> The semantics here the same as with other resource limits.
> 
>> Similarly, why do we do with an application running with something
>> incompatible with the larger address space that tries to raise the
>> limit?  Say, legacy MPX.
> 
> It has to know what it does. Yes, it can change limit to the point where
> application is unusable. But you can to the same with other limits.

I'm not sure I'm comfortable with this.  Do other rlimit changes cause
silent data corruption?  I'm pretty sure doing this to MPX would.

