Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdCNIeU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2017 04:34:20 -0400
Date: Tue, 14 Mar 2017 09:33:20 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] x86: 5-level paging enabling for v4.12, Part 1
In-Reply-To: <20170314082409.gjhefteglqbfb2gy@node.shutemov.name>
Message-ID: <alpine.DEB.2.20.1703140932310.3619@nanos>
References: <20170313143309.16020-1-kirill.shutemov@linux.intel.com> <20170314074729.GA23151@gmail.com> <20170314082409.gjhefteglqbfb2gy@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170314083320.DRgJ34dXz0xHejL2n6klKKBwtd2LQa-9BQDLZvVf7m4@z>

On Tue, 14 Mar 2017, Kirill A. Shutemov wrote:
> On Tue, Mar 14, 2017 at 08:47:29AM +0100, Ingo Molnar wrote:
> > I've also applied the GUP patch, with the assumption that you'll address Linus's 
> > request to switch x86 over to the generic version.
> 
> Okay, I'll do this.
> 
> I just want to make priorities clear here: is it okay to finish with the
> rest of 5-level paging patches first before moving to GUP_fast switch?

I think moving it first is the preferred way to do it.

Thanks,

	tglx
