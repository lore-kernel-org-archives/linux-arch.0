From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCHv2 6/8] x86/dump_pagetables: Add support 5-level paging
Date: Tue, 28 Mar 2017 23:38:59 +0200
Message-ID: <20170328213859.cltufwo5pdrhzna6@pd.tnic>
References: <20170328093946.GA30567@gmail.com>
 <20170328104806.41711-1-kirill.shutemov@linux.intel.com>
 <20170328185522.5akqgfh4niqi3ptf@pd.tnic>
 <20170328211507.ungejuigkewn6prl@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:35720 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbdC1VjQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Mar 2017 17:39:16 -0400
Content-Disposition: inline
In-Reply-To: <20170328211507.ungejuigkewn6prl@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Wed, Mar 29, 2017 at 12:15:07AM +0300, Kirill A. Shutemov wrote:
> On current tip/master?

tip/master from Monday:

commit d3b6ed97fbc63219e262faca86da2fe62885eff2 (refs/remotes/tip/master)
Merge: 399c980bd22b f2a6a7050109
Author: Ingo Molnar <mingo@kernel.org>
Date:   Mon Mar 27 10:48:30 2017 +0200

    Merge branch 'x86/mm'

> I'm not sure that collapsing history in one commit to fix bisectability is
> any better than having broken bisectability.

Of course it is better. How do you tell everyone who bisects in the
future to jump over those commits?

So perhaps not a single commit but at least meld those together which
change pagetable walking like the current example and cause a breakage.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
