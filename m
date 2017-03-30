Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35866 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932744AbdC3GWx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 02:22:53 -0400
Date: Thu, 30 Mar 2017 08:22:48 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 6/8] x86/dump_pagetables: Add support 5-level paging
Message-ID: <20170330062248.GA32658@gmail.com>
References: <20170328093946.GA30567@gmail.com>
 <20170328104806.41711-1-kirill.shutemov@linux.intel.com>
 <20170328185522.5akqgfh4niqi3ptf@pd.tnic>
 <20170328211507.ungejuigkewn6prl@node.shutemov.name>
 <20170329150010.dy47s4kcqsv4dmgz@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170329150010.dy47s4kcqsv4dmgz@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Borislav Petkov <bp@alien8.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170330062248.VHVHaoQaZEvfrXfERi7GTRU7Knyf_83NRwROYTC2uIM@z>


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> On Wed, Mar 29, 2017 at 12:15:07AM +0300, Kirill A. Shutemov wrote:
> > I'll try to look more into this issue tomorrow.
> 
> Putting this commit before seems f2a6a7050109 ("x86: Convert the rest of
> the code to support p4d_t") seems fixes the issue.

Ok, I've applied this patch standalone to make tip:x86/mm boot again.

Since half of the patches in this series got iterated please send out a clean v3 
series against the tip:x86/mm that I'm going to push out later today.

Thanks,

	Ingo
