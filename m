Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35190 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbdFVJHk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2017 05:07:40 -0400
Received: by mail-lf0-f66.google.com with SMTP id n136so1330056lfn.2
        for <linux-arch@vger.kernel.org>; Thu, 22 Jun 2017 02:07:39 -0700 (PDT)
Date: Thu, 22 Jun 2017 12:07:36 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv7 00/14] x86: 5-level paging enabling for v4.13, Part 4
Message-ID: <20170622090736.l5xcxazkeicughyt@node.shutemov.name>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
 <20170622085744.wetigtzctyzukbs5@node.shutemov.name>
 <20170622090422.wbbaw6pm457i7cbr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170622090422.wbbaw6pm457i7cbr@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170622090736.Hqeyz3vbVaMULzx7hzcJtjbVtAHBZmKpz70qfDPvH3Q@z>

On Thu, Jun 22, 2017 at 11:04:22AM +0200, Ingo Molnar wrote:
> 
> * Kirill A. Shutemov <kirill@shutemov.name> wrote:
> 
> > On Tue, Jun 06, 2017 at 02:31:19PM +0300, Kirill A. Shutemov wrote:
> > > Please review and consider applying.
> > 
> > Hi Ingo,
> > 
> > I've noticed you haven't applied last two patches of the patchset.
> > 
> > Is there any problem with them? Or what is you plan here?
> 
> As they change/extend the Linux ABI I still need to think about them some more.

Okay, I see.

Let me know if any action is required from my side.

-- 
 Kirill A. Shutemov
