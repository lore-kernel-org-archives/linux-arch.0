Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:23617 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755879AbcLOTZd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Dec 2016 14:25:33 -0500
Date: Thu, 15 Dec 2016 11:20:17 -0800
From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC, PATCHv1 15/28] x86: detect 5-level paging support
Message-ID: <20161215192017.GP8388@tassilo.jf.intel.com>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161208162150.148763-17-kirill.shutemov@linux.intel.com>
 <20161208200505.c6xiy56oufg6d24m@pd.tnic>
 <CA+55aFzgp+6c6RhgYvEjor=_+ewMeYL4XY4BqER5HMUknXBDCA@mail.gmail.com>
 <20161208202013.uutsny6avn5gimwq@pd.tnic>
 <b393a48a-6e8b-6427-373c-2825641fea99@zytor.com>
 <BD4BD1C9-F6FD-4905-9B09-059284FD2713@alien8.de>
 <20161215143944.ruxr6r3b2atg4tnf@pd.tnic>
 <E77F6B05-4F69-4C02-90B4-A8A6D0D392DE@zytor.com>
 <20161215190902.tdle4uj27xkc3x4i@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215190902.tdle4uj27xkc3x4i@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: hpa@zytor.com, Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20161215192017.vucsIW1U85vLdvXiTB_vG1FdlZ39ca3znAWaOxqWv-Y@z>


The code is not calling CPUID in any performance critical path, only
at initialization. So any discussion about saving a few instructions
is a complete waste of time.

-Andi
