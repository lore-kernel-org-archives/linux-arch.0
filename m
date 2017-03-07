Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:47193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753906AbdCGBBj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Mar 2017 20:01:39 -0500
Date: Tue, 7 Mar 2017 11:41:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv4 00/33] 5-level paging
Message-ID: <20170307114115.768312f4@canb.auug.org.au>
In-Reply-To: <alpine.DEB.2.20.1703061935220.3771@nanos>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
        <CA+55aFypZza_L5jyDEFwBrFZPR72R18RwTMz4TuV5sg0H4aaqA@mail.gmail.com>
        <alpine.DEB.2.20.1703061935220.3771@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170307004115.lnAbSPlzSfk1DW0EX4MITsQ98sh09RYtF6SmMisEaUg@z>

Hi Thomas,

On Mon, 6 Mar 2017 19:42:05 +0100 (CET) Thomas Gleixner <tglx@linutronix.de> wrote:
>
> We probably need to split it apart:
> 
>    - Apply the mm core only parts to a branch which can be pulled into
>      Andrews mm-tree

Andrew's mm-tree is not a git tree it is a quilt series ...

-- 
Cheers,
Stephen Rothwell
