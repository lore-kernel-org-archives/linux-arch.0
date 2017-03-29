From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2 6/8] x86/dump_pagetables: Add support 5-level paging
Date: Wed, 29 Mar 2017 18:00:10 +0300
Message-ID: <20170329150010.dy47s4kcqsv4dmgz@node.shutemov.name>
References: <20170328093946.GA30567@gmail.com>
 <20170328104806.41711-1-kirill.shutemov@linux.intel.com>
 <20170328185522.5akqgfh4niqi3ptf@pd.tnic>
 <20170328211507.ungejuigkewn6prl@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34927 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdC2PZN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2017 11:25:13 -0400
Received: by mail-wr0-f178.google.com with SMTP id k6so13819576wre.2
        for <linux-arch@vger.kernel.org>; Wed, 29 Mar 2017 08:25:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170328211507.ungejuigkewn6prl@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Wed, Mar 29, 2017 at 12:15:07AM +0300, Kirill A. Shutemov wrote:
> I'll try to look more into this issue tomorrow.

Putting this commit before seems f2a6a7050109 ("x86: Convert the rest of
the code to support p4d_t") seems fixes the issue.

-- 
 Kirill A. Shutemov
