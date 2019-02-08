Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:42725 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBHVuq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Feb 2019 16:50:46 -0500
Subject: Re: [PATCH 1/3] x86/mpx: tweak header name
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-2-mst@redhat.com> <20190208154239.GI674@zn.tnic>
 <20190208164206-mutt-send-email-mst@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <398c06e7-2d3e-1930-f1ec-58e36ccf9898@intel.com>
Date: Fri, 8 Feb 2019 13:50:46 -0800
MIME-Version: 1.0
In-Reply-To: <20190208164206-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190208215046.DYAy2If25kvvLV051Zp0fmpSJQ-EhLQBPEqYWQ066fQ@z>

On 2/8/19 1:43 PM, Michael S. Tsirkin wrote:
> On Fri, Feb 08, 2019 at 04:42:39PM +0100, Borislav Petkov wrote:
>> On Fri, Feb 08, 2019 at 01:02:53AM -0500, Michael S. Tsirkin wrote:
>>> Use linux/mman.h to make sure we get all mmap flags we need.
>> Why, asm/mman.h is not enough or is this fixing a build issue or what is that
>> patch supposed to address?
> Coding style violation: if a linux/foo.h exists then it must
> be included in preference to asm/foo.h

Huh, I don't see that one in Documentation/process/coding-style.rst

> And the specific issue is that a follow-up patch moves code from
> asm/mman.h to linux/mman.h so if any one was indirectly using
> this header it will now miss the symbols that are being moved.

Fair enough.  But, if this is the real reason, it belongs in the changelog.
