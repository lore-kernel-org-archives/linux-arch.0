From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level
 paging
Date: Fri, 26 May 2017 06:35:04 -0700
Message-ID: <20170526133504.GD24144@tassilo.jf.intel.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com>
 <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:60634 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936951AbdEZNfF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 09:35:05 -0400
Content-Disposition: inline
In-Reply-To: <20170526130057.t7zsynihkdtsepkf@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> Even ignoring all of above, I don't see much benefit of having per-mm
> switching. It adds complexity without much benefit -- saving few lines of
> logic during early boot doesn't look as huge win to me.

Also giving kthreads a different VM would prevent lazy VM switching
when switching from/to idle, which can be quite important for performance
when doing fast IO.

-Andi
