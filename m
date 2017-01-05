Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58313 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbdAETOD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Jan 2017 14:14:03 -0500
Subject: Re: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <20161227015413.187403-30-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5a3dcc25-b264-37c7-c090-09981b23940d@intel.com>
Date: Thu, 5 Jan 2017 11:13:57 -0800
MIME-Version: 1.0
In-Reply-To: <20161227015413.187403-30-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20170105191357.L3UW6neJ9uiyjN1jUWGy_WuhUhugLx1Ge0qurOOh1rk@z>

On 12/26/2016 05:54 PM, Kirill A. Shutemov wrote:
> MM would use min(RLIMIT_VADDR, TASK_SIZE) as upper limit of virtual
> address available to map by userspace.

What happens to existing mappings above the limit when this upper limit
is dropped?

Similarly, why do we do with an application running with something
incompatible with the larger address space that tries to raise the
limit?  Say, legacy MPX.
