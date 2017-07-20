Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38799 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbdGTH5n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jul 2017 03:57:43 -0400
Received: by mail-wm0-f51.google.com with SMTP id w191so19132677wmw.1
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 00:57:42 -0700 (PDT)
Date: Thu, 20 Jul 2017 10:57:40 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 0/8] 5-level paging enabling for v4.14
Message-ID: <20170720075740.4zo6hvkbjwrylfqe@node.shutemov.name>
References: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170720075740.ACUobz2q9EbnmKPILzQaUwaWmX0srOYWMZHeNy2IfXw@z>

On Mon, Jul 17, 2017 at 01:59:46AM +0300, Kirill A. Shutemov wrote:
> Hi,
> 
> As Ingo requested, I'm resending the rebased patchset after merge window to be
> queued for v4.14.
> 
> The patches was reordered and few more fixes added: for Xen and dump_pagetables.
> 
> Please consider applying.

Ingo, can we get this applied? You seems had no issue with the patchset
before merge window.

I would also appreciate feed on boot-time switching patchset.

-- 
 Kirill A. Shutemov
