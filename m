From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv7 00/14] x86: 5-level paging enabling for v4.13, Part 4
Date: Thu, 22 Jun 2017 11:04:22 +0200
Message-ID: <20170622090422.wbbaw6pm457i7cbr@gmail.com>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
 <20170622085744.wetigtzctyzukbs5@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35770 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdFVJE2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2017 05:04:28 -0400
Content-Disposition: inline
In-Reply-To: <20170622085744.wetigtzctyzukbs5@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> On Tue, Jun 06, 2017 at 02:31:19PM +0300, Kirill A. Shutemov wrote:
> > Please review and consider applying.
> 
> Hi Ingo,
> 
> I've noticed you haven't applied last two patches of the patchset.
> 
> Is there any problem with them? Or what is you plan here?

As they change/extend the Linux ABI I still need to think about them some more.

Thanks,

	Ingo
